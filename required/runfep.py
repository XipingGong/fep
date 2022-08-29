
# run FEP and free energy decomposition
# =====================================

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
#pdbid = 'ww_p'
#namea0 = 'CE2'
#namea1 = 'CD2'
#deviceid = '0'
pdbid = sys.argv[1]
namea0 = sys.argv[2]
namea1 = sys.argv[3]
deviceid = sys.argv[4]
nrun = sys.argv[5]
nrun = int(nrun)
#nrun = 50000 # nrun of each window --> 10 ns / window

ONE_4PI_EPS0 = 138.935456e0 * unit.kilojoule_per_mole * unit.nanometers /unit.elementary_charges**2
kB = 0.593e0/298.e0 # kcal/mol
T = 300.e0 # kelvin
temperature = T*unit.kelvin
beta = 1.e0/(kB*T)
dist0 = 1.35e0 # nm
dist1 = 0.12e0 # nm
nstep = 100 # 100 x 2fs --> g ~ 2 x tau + 1, tau ~ 100 fs
dab = 0.01e0 # nm
halfdab = 0.5e0*dab
nwindows = int((dist0-dist1)/dab)
sigmamax = 0.1 # kT
maxtol = sigmamax / np.sqrt(nwindows)
print("# nwindows = ", nwindows)
print("# sigmamax = ", sigmamax)
print("# maxtol=sigmamax/np.sqrt(nwinows) = ", maxtol)

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

# select atoms
pdb = md.load_pdb(pdbid+'.solv.pdb')
inxa0 =   pdb.topology.select('resid 0 and name '+namea0)
inxa1 =   pdb.topology.select('resid 1 and name '+namea1)
inxres0 = pdb.topology.select('resid 0')
inxres1 = pdb.topology.select('resid 1')


# load systems
with open(pdbid+'.solv.systemEtot.xml','r') as f:
    systemEtot = omm.XmlSerializer.deserialize(f.read())
with open(pdbid+'.solv.systemEvac.xml','r') as f:
    systemEvac = omm.XmlSerializer.deserialize(f.read())
with open(pdbid+'.solv.systemErep.xml','r') as f:
    systemErep = omm.XmlSerializer.deserialize(f.read())
with open(pdbid+'.solv.systemEdis.xml','r') as f:
    systemEdis = omm.XmlSerializer.deserialize(f.read())
with open(pdbid+'.solv.systemEvdw.xml','r') as f:
    systemEvdw = omm.XmlSerializer.deserialize(f.read())
with open(pdbid+'.solv.systemEele.xml','r') as f:
    systemEele = omm.XmlSerializer.deserialize(f.read())

# load state
with open(pdbid+'.solv.state.xml','r') as f:
    state = omm.XmlSerializer.deserialize(f.read())
# define reference coordinates
xyz = state.getPositions(asNumpy=True)
xyz0 = xyz[inxres1,2]
dist = np.abs(xyz[inxa0[0],2]-xyz[inxa1[0],2])*10.e0
print("# initial z-distance("+namea0+','+namea1+')', dist)

# create an integrator and simulation
dt = 2.e0*unit.femtoseconds
integratorEtot = omm.LangevinIntegrator(temperature, 1.e0/unit.picosecond, dt)
simulationEtot = app.Simulation(modeller.topology, systemEtot, integratorEtot,
        platform=platform, platformProperties=properties)
simulationEtot.context.setPeriodicBoxVectors(*state.getPeriodicBoxVectors())
simulationEtot.context.setPositions(state.getPositions())
simulationEtot.context.setVelocities(state.getVelocities())
simulationEtot.context.setTime(state.getTime())
prnfrq = nrun*nstep
simulationEtot.reporters.append(app.DCDReporter(pdbid+'.solv.dcd', prnfrq))
#rep = app.StateDataReporter(sys.stdout, prnfrq, separator=' ', step=True,
#        time=True, potentialEnergy=True, kineticEnergy=True, temperature=True, totalEnergy=True)
#simulationEtot.reporters.append(rep)

# creat extra simulations
integratorEvac = omm.LangevinIntegrator(temperature, 1.e0/unit.picosecond, dt)
simulationEvac = app.Simulation(modeller.topology, systemEvac, integratorEvac,
        platform=platform, platformProperties=properties)
integratorErep = omm.LangevinIntegrator(temperature, 1.e0/unit.picosecond, dt)
simulationErep = app.Simulation(modeller.topology, systemErep, integratorErep,
        platform=platform, platformProperties=properties)
integratorEdis = omm.LangevinIntegrator(temperature, 1.e0/unit.picosecond, dt)
simulationEdis = app.Simulation(modeller.topology, systemEdis, integratorEdis,
        platform=platform, platformProperties=properties)
integratorEvdw = omm.LangevinIntegrator(temperature, 1.e0/unit.picosecond, dt)
simulationEvdw = app.Simulation(modeller.topology, systemEvdw, integratorEvdw,
        platform=platform, platformProperties=properties)
integratorEele = omm.LangevinIntegrator(temperature, 1.e0/unit.picosecond, dt)
simulationEele = app.Simulation(modeller.topology, systemEele, integratorEele,
        platform=platform, platformProperties=properties)

# generate windows
distArr = np.linspace(dist0, dist1, endpoint=False, num=nwindows)
kwin = 0
irun = 0
nener = 6
diff = np.zeros((nwindows,nrun,nener))
fener = np.zeros((nwindows,2+nener*2))
fener[0,0] = distArr[0]*10.e0
fener[0,1] = distArr[0]*10.e0
print("# ----------------------------")
#nwindows = 2
for kwin in range(0,nwindows-1):

    d_a = distArr[kwin]
    d_b = distArr[kwin+1]
    dhalfba = 0.5e0*(d_a+d_b)
    xyz_a = xyz0 + (d_a-dist0)*unit.nanometers
    xyz_b = xyz0 + (d_b-dist0)*unit.nanometers
    xyz_halfba = xyz0 + (dhalfba-dist0)*unit.nanometers
    irun = 0
    print("# kwin >> ", kwin)
    print("# Calculating free energy in between two states: ", d_b*10.e0, d_a*10.e0)

    while irun < nrun:

        # update positions and velocities
        # simulationEtot.context.setVelocities(vel)
        xyz[inxres1,2] = xyz_halfba
        simulationEtot.context.setPositions(xyz)

        # md production
        simulationEtot.step(nstep)

        # get the final state
        state = simulationEtot.context.getState(getPositions=True,getEnergy=True)
        xyz = state.getPositions(asNumpy=True)

        # energy perturbation calculations
        # left perturbation
        # ---
        xyz[inxres1,2] = xyz_a
        # fener_a(x)
        simulationEtot.context.setPositions(xyz)
        state = simulationEtot.context.getState(getEnergy=True)
        d_a = np.abs(xyz[inxa0[0],2]-xyz[inxa1[0],2])*10.e0
        fener_a = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Evac_a(x)
        simulationEvac.context.setPositions(xyz)
        state = simulationEvac.context.getState(getEnergy=True)
        Evac_a = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Erep_a(x)
        simulationErep.context.setPositions(xyz)
        state = simulationErep.context.getState(getEnergy=True)
        Erep_a = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Edis_a(x)
        simulationEdis.context.setPositions(xyz)
        state = simulationEdis.context.getState(getEnergy=True)
        Edis_a = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Evdw_a(x)
        simulationEvdw.context.setPositions(xyz)
        state = simulationEvdw.context.getState(getEnergy=True)
        Evdw_a = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Eele_a(x)
        simulationEele.context.setPositions(xyz)
        state = simulationEele.context.getState(getEnergy=True)
        Eele_a = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        #
        # right perturbation
        # ---
        xyz[inxres1,2] = xyz_b
        # fener_b(x)
        simulationEtot.context.setPositions(xyz)
        state = simulationEtot.context.getState(getEnergy=True)
        d_b = np.abs(xyz[inxa0[0],2]-xyz[inxa1[0],2])*10.e0
        fener_b = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Evac_b(x)
        simulationEvac.context.setPositions(xyz)
        state = simulationEvac.context.getState(getEnergy=True)
        Evac_b = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Erep_b(x)
        simulationErep.context.setPositions(xyz)
        state = simulationErep.context.getState(getEnergy=True)
        Erep_b = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Edis_b(x)
        simulationEdis.context.setPositions(xyz)
        state = simulationEdis.context.getState(getEnergy=True)
        Edis_b = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Evdw_b(x)
        simulationEvdw.context.setPositions(xyz)
        state = simulationEvdw.context.getState(getEnergy=True)
        Evdw_b = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta
        # Eele_b(x)
        simulationEele.context.setPositions(xyz)
        state = simulationEele.context.getState(getEnergy=True)
        Eele_b = state.getPotentialEnergy()/unit.kilocalorie_per_mole * beta

        # relative difference
        diff[kwin+1,irun,0] = fener_b - fener_a
        diff[kwin+1,irun,1] = Evac_b - Evac_a
        diff[kwin+1,irun,2] = Erep_b - Erep_a
        diff[kwin+1,irun,3] = Edis_b - Edis_a
        diff[kwin+1,irun,4] = Eele_b - Eele_a
        diff[kwin+1,irun,5] = Evdw_b - Evdw_a
        #print("#Eele_b,Eele_a,diff = ", Eele_b, Eele_a, Eele_b-Eele_a)

        # continue to sample?
        irun += 1

    # save the final state?
    # simulationEtot.saveState(pdbid+'.solv.state.xml')

    # effective samples
    arr = diff[kwin+1,0:irun,0]
    g = timeseries.statisticalInefficiency(arr, fast=True)
    Neff = irun/g

    # save data?
    fener[kwin+1,0] = d_b
    fener[kwin+1,1] = d_a
    fener[kwin+1,2::2] = np.average(diff[kwin+1,0:irun,:],axis=0)
    fener[kwin+1,3::2] = np.std(diff[kwin+1,0:irun,:],ddof=1,axis=0)/np.sqrt(Neff)

    # print
    print("# statistical inefficiency (g) = ", g)
    print("# checking d_b, d_a = ", fener[kwin+1,0:2])
    print("# checking (Evac+Erep+Edis+Eele)-Fener= ", np.sum(fener[kwin+1,[4,6,8,10]])-fener[kwin+1,2])
    print("# checking (Erep+Edis)-Evdw           = ", np.sum(fener[kwin+1,[6,8]])-fener[kwin+1,12])
    print("# Fener: avg(kT), sem(kT)    = ", fener[kwin+1,2:4])
    print("# Evac : avg(kT), sem(kT)    = ", fener[kwin+1,4:6])
    print("# Erep : avg(kT), sem(kT)    = ", fener[kwin+1,6:8])
    print("# Edis : avg(kT), sem(kT)    = ", fener[kwin+1,8:10])
    print("# Eele : avg(kT), sem(kT)    = ", fener[kwin+1,10:12])
    print("# Evdw : avg(kT), sem(kT)    = ", fener[kwin+1,12:14])
    end = time.time()
    print("# elapsed wall-clock time (s) per run: ", end - start)
    print("")
    start = end

np.savetxt(pdbid+'.solv.fener', np.reshape(diff,(-1)),
        header="# free energy difference: np.reshape -> (nwindows,nrun,nener) = "+str(nwindows)+','+str(nrun)+','+str(nener))
np.savetxt(pdbid+'.solv.fener.pmf', fener, header="# db,da,fener(avg,sem),Evac,Erep,Edis,Eele,Evdw")
time_end = time.time()
print("# total elapsed wall-clock time (min): ", (time_end-time_start)/60.e0)

