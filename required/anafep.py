#/bin/python

import sys
import numpy as np
import pandas as pd
import time

time_start = time.time()
start = time.time()

pdbid = sys.argv[1]
nrun = int(sys.argv[2])
label = sys.argv[3]
nener = 6
nblock = 10

# import fener data
#dat = np.loadtxt(pdbid+'.solv.fener')
dat = pd.read_csv(pdbid+'.solv.fener',comment='#',header=None).values
dat = np.reshape(dat, (-1,nrun,nener))
nwins = dat.shape[0]
nener = dat.shape[2]
fener = np.loadtxt(pdbid+'.solv.fener.pmf')

out = np.zeros((nwins, 2*nener))
for kwin in range(0,nwins):
    for k in range(0,nener):
        xdat = np.sum(dat[0:kwin+1,0:nrun,k], axis=0)
        xdat = np.average(np.reshape(xdat, (nblock,-1)), axis=1) # nrun -> (nblock, nrun/block)
        avg = np.average(xdat)
        std = np.std(xdat)
        sem = std/np.sqrt(nblock)
        fener[kwin,2+2*k] = avg
        fener[kwin,2+2*k+1] = sem

np.savetxt(pdbid+'.'+label+'.Gong2022.pmf', fener[:,[0,2,3,4,5,6,7,8,9,10,11,12,13]], header="# dist(Ang),dGtot(avg,sem; kT),dGvac,dGrep,dGdis,dGele,dGvdw")
time_end = time.time()
#print("# total elapsed wall-clock time (min): ", (time_end-time_start)/60.e0)

