#!/bin/bash -f
#SBATCH --job-name="fep12"           # Job name
#SBATCH --nodes=1                # number of nodes # XXX
#SBATCH --gres=gpu:4           # number of gpus per node
#SBATCH -p slow                  # partition
#SBATCH -o job%j.log   # without -e, combine stdout/err
#SBATCH -e job%j.err

wdir=/home/ping/work/gbmv2np/fep/
ff=chm36mrtip4pd
nrun=50000

pdbid=wp_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun > runfep.log &"
      bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun > runfep.log &
cd $wdir

pdbid=wp_pda
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
echo "bash $ff.sh runfep $pdbid $atm1 $atm2 1 $nrun > runfep.log &"
      bash $ff.sh runfep $pdbid $atm1 $atm2 1 $nrun > runfep.log &
cd $wdir

pdbid=ff_etf
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
echo "bash $ff.sh runfep $pdbid $atm1 $atm2 2 $nrun > runfep.log &"
      bash $ff.sh runfep $pdbid $atm1 $atm2 2 $nrun > runfep.log &
cd $wdir

pdbid=ff_ap
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
echo "bash $ff.sh runfep $pdbid $atm1 $atm2 3 $nrun > runfep.log &"
      bash $ff.sh runfep $pdbid $atm1 $atm2 3 $nrun > runfep.log &
cd $wdir

wait
