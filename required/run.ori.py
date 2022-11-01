#/bin/python

# generate multiple run scripts to submit jobs
#
import os
pdbids=['ww_p','ww_pd','ww_ap','ww_apd','ww_etf','ww_etf2','wf_etf','wf_p',
        'wf_pd','wy_etf','wy_pd','wp_p','wp_pd','wp_pda','ff_etf','ff_ap',
        'ff_apd','fa_pd','fl_p','fl_pd','wl_pd','wl_pd2','wl_pd3','wa_pd',
        'aa_h','la_s','la_h','ll_p','bk','br','hb','hbco',
        'hh','he','hk','hr','ek','eks','re','qq',
        'hpbco','hpe','rrsa','bq2','wbco','ala2',
       ]
#pdbids=['wbco','ala2','ww_p','ww_pd',]
npdbids=len(pdbids)
ff='chm36mrtip4pd'
nrun='50000'

#wdir='/home/ping/pikes_home/work/gbmv2np/fep/'
wdir='/home/ping/work/gbmv2np/fep/'
ngpu=4

os.system('cd '+wdir)
for k in range(0,npdbids,ngpu):
    header="#!/bin/bash -f\n" + \
        "#SBATCH --job-name=\"fep"+str(k)+"\"           # Job name\n" + \
        "#SBATCH --nodes=1                # number of nodes # XXX\n" + \
        "#SBATCH --gres=gpu:4           # number of gpus per node\n" + \
        "#SBATCH -p slow                  # partition\n" + \
        "#SBATCH -o job%j.log   # without -e, combine stdout/err\n" + \
        "#SBATCH -e job%j.err\n" + \
        "\n"
    body="wdir="+wdir+"\n" + \
        "ff="+ff+"\n" + \
        "nrun="+nrun+"\n\n"
    for kk in range(0,ngpu):
        if k+kk < npdbids:
            pdbid=pdbids[k+kk]
            body+="pdbid="+pdbid+"\n" + \
                "atm1=`grep $pdbid/chm36m/chm36m.sh:atom1= $wdir/required/pdbids.dat | awk -F = '{print $2}'`\n" + \
                "atm2=`grep $pdbid/chm36m/chm36m.sh:atom2= $wdir/required/pdbids.dat | awk -F = '{print $2}'`\n" + \
                "FILE=$wdir/$pdbid/$ff\n" + \
                "mkdir -p $FILE\n" + \
                "cd $FILE\n" + \
                "echo \"bash $ff.sh runfep $pdbid $atm1 $atm2 "+str(kk)+" $nrun > runfep.log &\"\n" + \
                "      bash $ff.sh runfep $pdbid $atm1 $atm2 "+str(kk)+" $nrun > runfep.log &\n" + \
                "cd $wdir\n" + \
                "\n"
    body += "wait\n"
    with open(wdir+"run."+str(k)+".sh", 'w') as f:
        f.writelines(header+body)

    os.system("sbatch run."+str(k)+".sh")

