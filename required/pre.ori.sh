#!/bin/bash -f


wdir=/home/ping/pikes_home/work/gbmv2np/fep
ff=chm36mrtip4pd
nrun=50


pdbid=ww_p
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ww_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ww_ap
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ww_apd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ww_etf
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ww_etf2
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wf_etf
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wf_p
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wf_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wy_etf
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wy_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wp_p
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wp_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wp_pda
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ff_etf
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ff_ap
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ff_apd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=fa_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=fl_p
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=fl_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wl_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wl_pd2
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wl_pd3
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wa_pd
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=aa_h
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=la_s
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=la_h
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ll_p
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=bk
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=br
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=hb
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=hbco
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=hh
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=he
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=hk
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=hr
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ek
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=eks
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=re
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=qq
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=hpbco
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=hpe
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=rrsa
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=bq2
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=wbco
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

pdbid=ala2
atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`
FILE=$wdir/$pdbid/$ff
mkdir -p $FILE
cd $FILE
cp $wdir/required/$ff.sh $wdir/$pdbid/$ff
echo "bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log"
       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log
echo "bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log"
       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log
#echo "bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log"
#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log
cd $wdir

