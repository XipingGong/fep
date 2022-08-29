
# Evac decomposition
#

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

omm.Platform.loadPluginsFromDirectory('/home/ping/tutorial/ommplugins/gbmv/build/platforms/cuda')
import GBMVPlugin as gbmv

def calcEvac():

    # setting
    ONE_4PI_EPS0 = 138.935456e0 * unit.kilojoule_per_mole * unit.nanometers /unit.elementary_charges**2

    # Platforms
    platform = omm.Platform.getPlatformByName('CUDA')
    properties = {'CudaPrecision': 'mixed', 'DeviceIndex': deviceid}

    # create a modeller
    gromacs.GROMACS_TOPDIR = "../../required/"
    gro = gromacs.GromacsGroFile.parse(pdbid+'.vac.gro')
    top = gromacs.GromacsTopologyFile(pdbid+'.vac.top')
    top.box = gro.box
    print("# topology: ", top)

    # atom selection
    pdb = md.load_pdb(pdbid+'.vac.pdb')
    inxres0 = pdb.topology.select('resid 0')
    inxa0 =   pdb.topology.select('resid 0 and name '+namea0)
    inxres1 = pdb.topology.select('resid 1')
    inxa1 =   pdb.topology.select('resid 1 and name '+namea1)
    print('inxa0 = ', inxa0)
    print('inxa1 = ', inxa1)

    # create a system
    system = top.createSystem(nonbondedMethod=app.NoCutoff)
    for force in system.getForces():
        print("# system force: ", force)

    # extra a systemEtot
    systemEtot = top.createSystem(nonbondedMethod=app.NoCutoff)
    forces = systemEtot.getForces()
    for k in range(0,len(forces)):
        systemEtot.removeForce(0)
    forceEtot = omm.CustomBondForce('ONE_4PI_EPS0*q12/r + 4*eps12*((sig12/r)^12 - (sig12/r)^6)')
    forceEtot.addGlobalParameter('ONE_4PI_EPS0', ONE_4PI_EPS0)
    forceEtot.addPerBondParameter('q12')
    forceEtot.addPerBondParameter('sig12')
    forceEtot.addPerBondParameter('eps12')
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
        forceEtot.addBond(p1,p2,[q12,sig12,eps12])
    systemEtot.addForce(forceEtot)

    # extra a systemEele
    systemEele = top.createSystem(nonbondedMethod=app.NoCutoff)
    forces = systemEele.getForces()
    for k in range(0,len(forces)):
        systemEele.removeForce(0)
    forceEele = omm.CustomBondForce('ONE_4PI_EPS0*q12/r')
    forceEele.addGlobalParameter('ONE_4PI_EPS0', ONE_4PI_EPS0)
    forceEele.addPerBondParameter('q12')
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
        forceEele.addBond(p1,p2,[q12])
    systemEele.addForce(forceEele)

    # extra a systemEvdw
    systemEvdw = top.createSystem(nonbondedMethod=app.NoCutoff)
    forces = systemEvdw.getForces()
    for k in range(0,len(forces)):
        systemEvdw.removeForce(0)
    forceEvdw = omm.CustomBondForce('4*eps12*((sig12/r)^12 - (sig12/r)^6)')
    forceEvdw.addPerBondParameter('sig12')
    forceEvdw.addPerBondParameter('eps12')
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
        forceEvdw.addBond(p1,p2,[sig12,eps12])
    systemEvdw.addForce(forceEvdw)

    # create simulations
    integrator = omm.LangevinIntegrator(temperature, 1.0/unit.picosecond, 0.002*unit.picoseconds)
    simulation = app.Simulation(top.topology, system, integrator, platform=platform, platformProperties=properties)
    simulation.context.setPositions(gro.positions)
    integratorEtot = omm.LangevinIntegrator(temperature, 1.0/unit.picosecond, 0.002*unit.picoseconds)
    simulationEtot = app.Simulation(top.topology, systemEtot, integratorEtot, platform=platform, platformProperties=properties)
    simulationEtot.context.setPositions(gro.positions)
    integratorEele = omm.LangevinIntegrator(temperature, 1.0/unit.picosecond, 0.002*unit.picoseconds)
    simulationEele = app.Simulation(top.topology, systemEele, integratorEele, platform=platform, platformProperties=properties)
    simulationEele.context.setPositions(gro.positions)
    integratorEvdw = omm.LangevinIntegrator(temperature, 1.0/unit.picosecond, 0.002*unit.picoseconds)
    simulationEvdw = app.Simulation(top.topology, systemEvdw, integratorEvdw, platform=platform, platformProperties=properties)
    simulationEvdw.context.setPositions(gro.positions)

    # initial xyz
    state = simulation.context.getState(getPositions=True,getEnergy=True)
    xyz = state.getPositions(asNumpy=True)
    xyzref = xyz[inxres1,2]

    evac = np.zeros((nwindows,5))
    print("# #windows to generate: ", nwindows)
    print("#----------------------------")
    for k in range(0,nwindows):
        # move to a window
        xyz[inxres1,2] = xyzref + (distArr[k]-dist0)*unit.nanometers
        simulation.context.setPositions(xyz)

       ## energy minimization
       #simulation.minimizeEnergy()
       #state = simulation.context.getState(getPositions=True,getEnergy=True)
       #xyz = state.getPositions(asNumpy=True)

        simulationEtot.context.setPositions(xyz)
        simulationEele.context.setPositions(xyz)
        simulationEvdw.context.setPositions(xyz)

        # energy calculations
        state = simulation.context.getState(getPositions=True,getEnergy=True)
        pos = state.getPositions(asNumpy=True)
        dist = np.abs(pos[inxa0[0],2] - pos[inxa1[0],2])*10.e0
        ener = state.getPotentialEnergy().in_units_of(unit.kilocalorie_per_mole)
        ener = ener/unit.kilocalorie_per_mole
        evac[k,0] = dist
        evac[k,1] = ener*beta

        # Etot
        state = simulationEtot.context.getState(getPositions=True,getEnergy=True)
        pos = state.getPositions(asNumpy=True)
        ener = state.getPotentialEnergy().in_units_of(unit.kilocalorie_per_mole)
        ener = ener/unit.kilocalorie_per_mole
        evac[k,2] = ener*beta

        # Eele
        state = simulationEele.context.getState(getPositions=True,getEnergy=True)
        pos = state.getPositions(asNumpy=True)
        ener = state.getPotentialEnergy().in_units_of(unit.kilocalorie_per_mole)
        ener = ener/unit.kilocalorie_per_mole
        evac[k,3] = ener*beta

        # Evdw
        state = simulationEvdw.context.getState(getPositions=True,getEnergy=True)
        pos = state.getPositions(asNumpy=True)
        ener = state.getPotentialEnergy().in_units_of(unit.kilocalorie_per_mole)
        ener = ener/unit.kilocalorie_per_mole
        evac[k,4] = ener*beta

    evac[:,1:] -= evac[0,1:] # set initial point zero
    return evac

# main
# ----
# setting
#pdbid = 'ala2'
#namea0 = 'HL'
#namea1 = 'OR'
#deviceid = '0'
pdbid = sys.argv[1]
namea0 = sys.argv[2]
namea1 = sys.argv[3]
deviceid = sys.argv[4]
#
dist0 = 1.35e0
dist1 = 0.12e0
dab = 0.01e0 # nm
nwindows = int((dist0-dist1)/dab)
distArr = np.linspace(dist0, dist1, endpoint=False, num=nwindows)
kB = 0.593e0/298.e0 # kcal/mol
T = 300.e0 # kelvin
temperature = T*unit.kelvin
beta = 1.e0/(kB*T)
SA0 = 20.92e0 # 0.050 kcal/mol
SC0 = 1.e0

print("# calculating Evac")
dat = calcEvac()

header = '#window, 0-dist(A), 1-dGvac (kT), 2-dEtot, 3-dEele, 4-dEvdw'
np.savetxt(pdbid+'.evac.pmf', dat, header=header)
print('# Done')

