#/bin/bash

# inputs
# ------
# pdbid: $pdbid.ori.pdb


# 1. setting
pdbid=ala2
atom1=HL
atom2=OR
BOXSIZEX=2.660
BOXSIZEY=2.660
BOXSIZEZ=3.600
deviceid=0
nrun=50 # nsamples of each window

# clean
shopt -s extglob
if [ $1 == 'clean' ]; then
   rm !("chm36m.sh"|*.pmf)
fi

# 2. generate gromacs topology and structure for vac and solvate systems
if [ $1 == 'genstr' ]; then
   gmx='/home/ping/Work/GROMACS/gromacs-2019.2/build/bin/gmx'
   export GMXLIB=../../required
   $gmx editconf -f ../$pdbid.ori.pdb -box $BOXSIZEX $BOXSIZEY $BOXSIZEZ -o $pdbid.box.pdb
   # vac
   $gmx pdb2gmx -f $pdbid.box.pdb -o $pdbid.vac.gro -p $pdbid.vac.top -ff a99SBdisp-addsidechain -water none
   $gmx editconf -f $pdbid.vac.gro -o $pdbid.vac.pdb
   # solv
   echo '1' | $gmx pdb2gmx -f $pdbid.box.pdb -o $pdbid.box.gro -p $pdbid.solv.top -ff a99SBdisp-addsidechain #-water a99SBdisp_water
   $gmx solvate -cp $pdbid.box.gro -cs a99SBdisp-addsidechain.ff/a99SBdisp_water.gro -o $pdbid.solv.gro -p $pdbid.solv.top
   $gmx editconf -f $pdbid.solv.gro -o $pdbid.solv.pdb
   rm posre.itp
   rm *.box.*
   rm \#*
fi

# 3. generate systems and state xml files
if [ $1 == 'prefep' ]; then
   echo "python ../../required/prefep.py $pdbid $atom1 $atom2 $deviceid"
         python ../../required/prefep.py $pdbid $atom1 $atom2 $deviceid
fi

# 4. check $pdbid.solv.top, .pdb, and .gro files using vmd
# vmd $pdbid.solv.gro $pdbid.solv.dcd

# 5. run fep simulation
if [ $1 == 'runfep' ]; then
   echo "python ../../required/runfep.py $pdbid $atom1 $atom2 $deviceid $nrun"
         python ../../required/runfep.py $pdbid $atom1 $atom2 $deviceid $nrun
fi

