
# Prepreation for FEP and
# free energy decomposition
# =========================
# input :
#    pdbid.solv.gro, pdbid.solv.pdb, pdbid.solv.top
# output:
#    pdbid.solv.system*.xml - define biasing potentials
#    pdbid.solv.state.xml - include the equilibrium state for md productions
#
# nonboned energy formulas
# REF. https://github.com/openmm/openmm/issues/3281
#      How to reproduce standard nonbonded force as a custom nonbonded force? #3281

# OpenMM
import simtk.openmm as omm # contains functions for MD
import simtk.openmm.app as app # contains functions for i/o
from simtk import unit # controls unique object types for physical units
import sys
import numpy as np
import mdtraj as md
import time
from parmed import gromacs
import cProfile
from pymbar import timeseries

time_start = time.time()
start = time.time()

# setting
#pdbid = 'ala2'
#namea0 = 'HR'
#namea1 = 'OL'
#deviceid = '0'
pdbid = sys.argv[1]
namea0 = sys.argv[2]
namea1 = sys.argv[3]
deviceid = sys.argv[4]

ONE_4PI_EPS0 = 138.935456e0 * unit.kilojoule_per_mole * unit.nanometers /unit.elementary_charges**2
kB = 0.593e0/298.e0 # kcal/mol
T = 300.e0 # kelvin
temperature = T*unit.kelvin
beta = 1.e0/(kB*T)

# Platforms
platform = omm.Platform.getPlatformByName('CUDA')
properties = {'CudaPrecision': 'mixed', 'DeviceIndex': deviceid}

# create a modeller
gromacs.GROMACS_TOPDIR = "../../required/"
gro = gromacs.GromacsGroFile.parse(pdbid+'.solv.gro')
top = gromacs.GromacsTopologyFile(pdbid+'.solv.top')
top.box = gro.box
modeller = app.Modeller(top.topology, gro.positions)
print("# topology: ", top)

# create a system
systemEtot = top.createSystem(nonbondedMethod=app.CutoffPeriodic,
                          nonbondedCutoff=1.2e0*unit.nanometers,
                          rigidWater=True,)
print("# pbc?: ", systemEtot.usesPeriodicBoundaryConditions())
print("# default box size: ", systemEtot.getDefaultPeriodicBoxVectors())

# add force to fix residues
pdb = md.load_pdb(pdbid+'.solv.pdb')
inxa0 =   pdb.topology.select('resid 0 and name '+namea0)
inxa1 =   pdb.topology.select('resid 1 and name '+namea1)
resid = pdb.topology.select('not waters')
for k in resid:
    systemEtot.setParticleMass(int(k), 0.e0*unit.dalton)

# remove dispersion corrections of nonbonded forces
for force in systemEtot.getForces():
    print("# force: ", force)
    if isinstance(force, omm.NonbondedForce):
        force.setUseDispersionCorrection(False)
        eps_solvent = force.getReactionFieldDielectric()
        CUTOFF = force.getCutoffDistance()
    if isinstance(force, omm.CustomNonbondedForce):
        force.setUseLongRangeCorrection(False)
print('# CUTOFF: ', CUTOFF)
print("# eps_solvent = ", eps_solvent)
krf = (1/ (CUTOFF**3)) * (eps_solvent - 1) / (2*eps_solvent + 1)
crf = (1/ CUTOFF) * (3* eps_solvent) / (2*eps_solvent + 1)

# save a system
with open(pdbid+'.solv.systemEtot.xml', 'w') as f:
    f.write(omm.XmlSerializer.serialize(systemEtot))

# create an integrator and simulation
nsteps = 50*1000
prnfrq = nsteps
dt = 1.e0*unit.femtoseconds
integratorEtot = omm.LangevinIntegrator(temperature, 1.e0/unit.picosecond, dt)
simulationEtot = app.Simulation(modeller.topology, systemEtot, integratorEtot,
        platform=platform, platformProperties=properties)
simulationEtot.context.setPositions(gro.positions)
simulationEtot.reporters.append(app.DCDReporter(pdbid+'.solv.dcd', prnfrq))
rep = app.StateDataReporter(sys.stdout, prnfrq, separator=' ', step=True,
        time=True, potentialEnergy=True, kineticEnergy=True, temperature=True, totalEnergy=True)
simulationEtot.reporters.append(rep)

# md equilibrium
simulationEtot.step(nsteps)

# save an equilibrium state
state = simulationEtot.context.getState(getPositions=True)
xyz = state.getPositions(asNumpy=True)
dist = np.abs(xyz[inxa0[0],2]-xyz[inxa1[0],2])*10.e0
print("# initial z-distance("+namea0+','+namea1+')', dist)
simulationEtot.saveState(pdbid+'.solv.state.xml')

# free energy decomposition --> define additional systems
# -------
# Evac_pp
with open(pdbid+'.solv.systemEtot.xml','r') as f:
    systemEvac = omm.XmlSerializer.deserialize(f.read())
forces = systemEvac.getForces()
for k in range(0,len(forces)):
    # once the force is removed, then force indeices will be reduced by one
    systemEvac.removeForce(0)
# forceEvac = omm.CustomBondForce('ONE_4PI_EPS0*q12/r + 4*eps12*((sig12/r)^12 - (sig12/r)^6)')
forceEvac = omm.CustomBondForce('ONE_4PI_EPS0*q12*(1/r+krf*r*r-crf)*step(1-r/CUTOFF) + 4*eps12*((sig12/r)^12 - (sig12/r)^6)*step(1-r/CUTOFF)')
forceEvac.setUsesPeriodicBoundaryConditions(True)
forceEvac.addGlobalParameter('ONE_4PI_EPS0', ONE_4PI_EPS0)
forceEvac.addGlobalParameter('CUTOFF', CUTOFF)
forceEvac.addGlobalParameter('krf', krf)
forceEvac.addGlobalParameter('crf', crf)
forceEvac.addPerBondParameter('q12')
forceEvac.addPerBondParameter('sig12')
forceEvac.addPerBondParameter('eps12')
# add forces
inx_pp = pdb.topology.select_pairs(selection1='resid 1',selection2='resid 0')
for inx in inx_pp:
    p1 = int(inx[0])
    p2 = int(inx[1])
    q1 = top.atoms[p1].ucharge
    sig1 = top.atoms[p1].usigma
    eps1 = top.atoms[p1].uepsilon
    q2 = top.atoms[p2].ucharge
    sig2 = top.atoms[p2].usigma
    eps2 = top.atoms[p2].uepsilon
    q12 = q1*q2
    sig12 = (sig1+sig2)*0.5e0
    eps12 = unit.Quantity.sqrt(eps1*eps2)
    type1 = top.atoms[p1].type
    type2 = top.atoms[p2].type
    if (type1=='OB' and type2=='HB') or (type1=='HB' and type2=='OB'):
        sig12 = 0.15e0
        eps12 = 1.2552e0 # OB HB 1 0.150 1.2552
    forceEvac.addBond(p1,p2,[q12,sig12,eps12])
systemEvac.addForce(forceEvac)
# Eele_pw
with open(pdbid+'.solv.systemEtot.xml','r') as f:
    systemEele = omm.XmlSerializer.deserialize(f.read())
forces = systemEele.getForces()
for k in range(0,len(forces)):
    systemEele.removeForce(0)
# forceEele = omm.CustomBondForce('ONE_4PI_EPS0*q12/r')
forceEele = omm.CustomBondForce('ONE_4PI_EPS0*q12*(1/r+krf*r*r-crf)*step(1-r/CUTOFF)')
forceEele.setUsesPeriodicBoundaryConditions(True)
forceEele.addGlobalParameter('ONE_4PI_EPS0', ONE_4PI_EPS0)
forceEele.addGlobalParameter('CUTOFF', CUTOFF)
forceEele.addGlobalParameter('krf', krf)
forceEele.addGlobalParameter('crf', crf)
forceEele.addPerBondParameter('q12')
# Erep_pw
with open(pdbid+'.solv.systemEtot.xml','r') as f:
    systemErep = omm.XmlSerializer.deserialize(f.read())
forces = systemErep.getForces()
for k in range(0,len(forces)):
    systemErep.removeForce(0)
forceErep = omm.CustomBondForce('(4*eps12*((sig12/r)^12 - (sig12/r)^6)+eps12)*step(2^(1/6)*sig12-r)')
forceErep.setUsesPeriodicBoundaryConditions(True)
forceErep.addPerBondParameter('sig12')
forceErep.addPerBondParameter('eps12')
# Edis_pw
with open(pdbid+'.solv.systemEtot.xml','r') as f:
    systemEdis = omm.XmlSerializer.deserialize(f.read())
forces = systemEdis.getForces()
for k in range(0,len(forces)):
    systemEdis.removeForce(0)
# forceEdis = omm.CustomBondForce('((4*eps12*((sig12/r)^12 - (sig12/r)^6)+eps12)*step(r-2^(1/6)*sig12)-eps12)')
forceEdis = omm.CustomBondForce('((4*eps12*((sig12/r)^12 - (sig12/r)^6)+eps12)*step(r-2^(1/6)*sig12)-eps12)*step(1-r/CUTOFF)')
forceEdis.setUsesPeriodicBoundaryConditions(True)
forceEdis.addGlobalParameter('CUTOFF', CUTOFF)
forceEdis.addPerBondParameter('sig12')
forceEdis.addPerBondParameter('eps12')
# Evdw_pw
with open(pdbid+'.solv.systemEtot.xml','r') as f:
    systemEvdw = omm.XmlSerializer.deserialize(f.read())
forces = systemEvdw.getForces()
for k in range(0,len(forces)):
    systemEvdw.removeForce(0)
# add new forces
# forceEvdw = omm.CustomBondForce('4*eps12*((sig12/r)^12 - (sig12/r)^6)')
forceEvdw = omm.CustomBondForce('4*eps12*((sig12/r)^12 - (sig12/r)^6)*step(1-r/CUTOFF)')
forceEvdw.setUsesPeriodicBoundaryConditions(True)
forceEvdw.addGlobalParameter('CUTOFF', CUTOFF)
forceEvdw.addPerBondParameter('sig12')
forceEvdw.addPerBondParameter('eps12')
# add forces
inx_pw = pdb.topology.select_pairs(selection1='resid 1', selection2='waters')
for inx in inx_pw:
    p1 = int(inx[0])
    p2 = int(inx[1])
    q1 = top.atoms[p1].ucharge
    sig1 = top.atoms[p1].usigma
    eps1 = top.atoms[p1].uepsilon
    q2 = top.atoms[p2].ucharge
    sig2 = top.atoms[p2].usigma
    eps2 = top.atoms[p2].uepsilon
    q12 = q1*q2
    sig12 = (sig1+sig2)*0.5e0
    eps12 = unit.Quantity.sqrt(eps1*eps2)
    #print(q12, sig12, eps12)
    forceErep.addBond(p1,p2,[sig12,eps12])
    forceEdis.addBond(p1,p2,[sig12,eps12])
    forceEvdw.addBond(p1,p2,[sig12,eps12])
    forceEele.addBond(p1,p2,[q12,])
systemErep.addForce(forceErep)
systemEdis.addForce(forceEdis)
systemEvdw.addForce(forceEvdw)
systemEele.addForce(forceEele)

# save additional systems
with open(pdbid+'.solv.systemEvac.xml', 'w') as f:
    f.write(omm.XmlSerializer.serialize(systemEvac))
with open(pdbid+'.solv.systemErep.xml', 'w') as f:
    f.write(omm.XmlSerializer.serialize(systemErep))
with open(pdbid+'.solv.systemEdis.xml', 'w') as f:
    f.write(omm.XmlSerializer.serialize(systemEdis))
with open(pdbid+'.solv.systemEvdw.xml', 'w') as f:
    f.write(omm.XmlSerializer.serialize(systemEvdw))
with open(pdbid+'.solv.systemEele.xml', 'w') as f:
    f.write(omm.XmlSerializer.serialize(systemEele))

