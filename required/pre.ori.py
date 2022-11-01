#/bin/python

# generate a bash script to prerun the jobs
#
import os
pdbids=['ww_p','ww_pd','ww_ap','ww_apd','ww_etf','ww_etf2','wf_etf','wf_p',
        'wf_pd','wy_etf','wy_pd','wp_p','wp_pd','wp_pda','ff_etf','ff_ap',
        'ff_apd','fa_pd','fl_p','fl_pd','wl_pd','wl_pd2','wl_pd3','wa_pd',
        'aa_h','la_s','la_h','ll_p','bk','br','hb','hbco',
        'hh','he','hk','hr','ek','eks','re','qq',
        'hpbco','hpe','rrsa','bq2','wbco','ala2',
       ]
#pdbids=['ww_p','ww_pd','ww_ap','ww_apd',]
#pdbids=['bq2',]
npdbids=len(pdbids)

wdir='/home/ping/pikes_home/work/gbmv2np/fep'
#wdir='/home/ping/work/gbmv2np/fep'

os.system('cd '+wdir)
print("#!/bin/bash -f")
print("\n")

print("wdir="+wdir)
print("ff=chm36mrtip4pd")
print("nrun=50")
print("\n")

for k in range(0,npdbids):
    pdbid=pdbids[k]
    print("pdbid="+pdbid+"\n"
         +"atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`\n"
         +"atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`\n"
         +"FILE=$wdir/$pdbid/$ff\n"
         +"mkdir -p $FILE\n"
         +"cd $FILE\n"
         +"cp $wdir/required/$ff.sh $wdir/$pdbid/$ff\n"
         +"echo \"bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log\"\n"
         +"       bash $ff.sh genstr $pdbid $atm1 $atm2 0 $nrun | tee genstr.log\n"
         +"echo \"bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log\"\n"
         +"       bash $ff.sh prefep $pdbid $atm1 $atm2 0 $nrun | tee prefep.log\n"
         +"#echo \"bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log\"\n"
         +"#       bash $ff.sh runfep $pdbid $atm1 $atm2 0 $nrun | tee runfep.log\n"
         +"cd $wdir"
         +"\n"
         )

