#/bin/bash

# inputs
# ------
# pdbid: $pdbid.ori.pdb


# 1. setting
pdbid=$2 #ala2
atom1=$3 #HL
atom2=$4 #OR
BOXSIZEX=2.660
BOXSIZEY=2.660
BOXSIZEZ=3.600
deviceid=$5 #0
nrun=$6 #50 # nsamples of each window
gmx='/home/ping/Work/GROMACS/gromacs-2019.2/build/bin/gmx'
#gmx='/home/zgjia/Software/gromacs/gromacs514GPU_plumed/bin/gmx_mpi'

# clean
shopt -s extglob
if [ $1 == 'clean' ]; then
   rm !(*.pmf | *.sh)
fi

# 2. generate gromacs topology and structure for vac and solvate systems
if [ $1 == 'genstr' ]; then
   export GMXLIB=../../required
   $gmx editconf -f ../$pdbid.ori.pdb -box $BOXSIZEX $BOXSIZEY $BOXSIZEZ -o $pdbid.box.pdb
   # vac
   $gmx pdb2gmx -f $pdbid.box.pdb -o $pdbid.vac.gro -p $pdbid.vac.top -ff c36mrbdisp-addsidechain -water none
   $gmx editconf -f $pdbid.vac.gro -o $pdbid.vac.pdb
   # solv
   echo '1' | $gmx pdb2gmx -f $pdbid.box.pdb -o $pdbid.box.gro -p $pdbid.solv.top -ff c36mrtip4pd-addsidechain #-water a99SBdisp_water
   $gmx solvate -cp $pdbid.box.gro -cs c36mrbdisp-addsidechain.ff/a99SBdisp_water.gro -o $pdbid.solv.gro -p $pdbid.solv.top
   $gmx editconf -f $pdbid.solv.gro -o $pdbid.solv.pdb
   # modify pdbs
   sed -i 's/1HH1/HH11/g' $pdbid.*.pdb
   sed -i 's/2HH1/HH12/g' $pdbid.*.pdb
   sed -i 's/1HH2/HH21/g' $pdbid.*.pdb
   sed -i 's/2HH2/HH22/g' $pdbid.*.pdb
   sed -i 's/1HE1/HE11/g' $pdbid.*.pdb
   sed -i 's/2HE1/HE12/g' $pdbid.*.pdb
   sed -i 's/1HE2/HE21/g' $pdbid.*.pdb
   sed -i 's/2HE2/HE22/g' $pdbid.*.pdb
   # remove
   rm posre.itp
   rm *.box.*
   rm \#*
fi

# 3. generate systems and state xml files
if [ $1 == 'prefep' ]; then
   echo "python ../../required/prefep.py $pdbid $atom1 $atom2 $deviceid"
         python ../../required/prefep.py $pdbid $atom1 $atom2 $deviceid

  # modify the nonbonded parameters
fi

# 4. check $pdbid.solv.top, .pdb, and .gro files using vmd
# vmd $pdbid.solv.gro $pdbid.solv.dcd

# 5. run fep simulation
if [ $1 == 'runfep' ]; then
   echo "python ../../required/runfep.py $pdbid $atom1 $atom2 $deviceid $nrun"
         python ../../required/runfep.py $pdbid $atom1 $atom2 $deviceid $nrun
fi

