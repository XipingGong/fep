#!/bin/csh -f
#SBATCH --job-name="ala2"           # Job name
#SBATCH --nodes=1                # number of nodes # XXX
#SBATCH --gres=gpu:4           # number of gpus per node
#SBATCH -p slow                  # partition
#SBATCH -o job%j.log   # without -e, combine stdout/err
#SBATCH -e job%j.err

set wdir = "/home/ping/tutorial/fep/"

# pdbids
# ------
set resid = ( ala2 HL OR )
set cnt = 1
set nrun = 50
while ( $cnt <= $#resid )
    set pdbid = $resid[$cnt]; @ cnt++
    set atom1 = $resid[$cnt]; @ cnt++
    set atom2 = $resid[$cnt]; @ cnt++

    # chm36m
    set run = chm36m
    cp $wdir/required/$run.sh $wdir/$pdbid/$run/
    echo "cd $wdir/$pdbid/$run/"
    cd $wdir/$pdbid/$run
    bash $run.sh clean $pdbid $atom1 $atom2 0 $nrun
   #bash $run.sh genstr $pdbid $atom1 $atom2 0 $nrun
   #bash $run.sh prefep $pdbid $atom1 $atom2 0 $nrun
   #bash $run.sh runfep $pdbid $atom1 $atom2 0 $nrun &

    # chm36mw
    set run = chm36mw
    cp $wdir/required/$run.sh $wdir/$pdbid/$run/
    echo "cd $wdir/$pdbid/$run/"
    cd $wdir/$pdbid/$run
    bash $run.sh clean $pdbid $atom1 $atom2 0 $nrun
   #bash $run.sh genstr $pdbid $atom1 $atom2 1 $nrun
   #bash $run.sh prefep $pdbid $atom1 $atom2 1 $nrun
   #bash $run.sh runfep $pdbid $atom1 $atom2 1 $nrun &

    # a99sbdisp
    set run = a99sbdisp
    cp $wdir/required/$run.sh $wdir/$pdbid/$run/
    echo "cd $wdir/$pdbid/$run/"
    cd $wdir/$pdbid/$run
    bash $run.sh clean $pdbid $atom1 $atom2 0 $nrun
   #bash $run.sh genstr $pdbid $atom1 $atom2 2 $nrun
   #bash $run.sh prefep $pdbid $atom1 $atom2 2 $nrun
   #bash $run.sh runfep $pdbid $atom1 $atom2 2 $nrun &

end

wait
