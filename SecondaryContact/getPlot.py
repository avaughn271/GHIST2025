import numpy as np
import msprime
import pandas
from scipy.optimize import minimize
from numpy import genfromtxt
from math import log10


mu =  8.4 * (10**-8)
L = 10000000 
numberofunits = 500
repitations = 2
empirical = genfromtxt('Final.csv', delimiter=' ')
empirical = empirical / np.sum(empirical)

eastids = []
for i in range(0,48):
	eastids.append(i)
westids = []
for i in range(48,48+22):
	westids.append(i)

def kl(E, X):
	test1 = 0
	test2 =  0

	largesum = 0
	for i in range(45):
		for j in range(37):
			if E[i,j] > 0 and X[i,j] > 0:
				largesum = largesum + X[i,j] * np.log(X[i,j]  / E[i,j])
				test1 = test1 +  X[i,j] 
				test2 = test2 +  E[i,j] 
	print("test", test1, test2)
	return np.sum(largesum)

def getTrees(N_main, N_island,  N_ancestral, T_split, T_mig, migrate1):
	demography = msprime.Demography()

	demography.add_population(name="island", initial_size=N_island)
	demography.add_population(name="mainland", initial_size=N_main)
	demography.add_population(name="ancestral", initial_size=N_ancestral)

	demography.add_migration_rate_change(time = 0.00000001,  rate = migrate1, source="island", dest="mainland")
	demography.add_migration_rate_change(time = 0.00000002,  rate = migrate1, source="mainland", dest="island")

	demography.add_migration_rate_change(time = T_mig,  rate = 0.0, source="island", dest="mainland")
	demography.add_migration_rate_change(time = T_mig + 0.0000000001,  rate = 0.0, source="mainland", dest="island")

	demography.add_population_split(time=T_split, derived=["mainland", "island"], ancestral="ancestral")
	return msprime.sim_ancestry({"mainland": 24, "island": 11}, demography=demography, 
						    sequence_length = L / numberofunits, recombination_rate = 5.4 * 10**(-8),  
							num_replicates = numberofunits)

def getvalue(N_east, N_west,  N_ancestral, T_split, T_mig, migrate1):
	SFSFULL = np.zeros((49,23))
	for _ in range(repitations):
		SFS = np.zeros((49,23))
		tre = getTrees(N_east, N_west,  N_ancestral, T_split, T_mig, migrate1)
		totalmut = 0

		for ts in tre:
			mts = msprime.sim_mutations(ts, rate=mu  , model = "binary")
			totalmut = totalmut + np.sum(mts.allele_frequency_spectrum([eastids, westids], mode='site', polarised=True, span_normalise = False))
			SFS = SFS + mts.allele_frequency_spectrum([eastids, westids], mode='branch', polarised=True, span_normalise = False)
		SFS = np.divide(SFS, np.divide(np.sum(SFS)  , totalmut) )

		SFS[0,0]  = L - np.sum(SFS)
		SFS = np.divide(SFS, L)
		SFSFULL = np.add(SFSFULL , SFS)
	return np.divide(SFSFULL , repitations)

N_east = 125992
N_west=20109
N_ancestral= 100000
T_split= 13302.758875
A = getvalue( 45380.0  ,  
			 7213.00 ,  
			 60000  ,  
			 23350.0 ,  #13500
			 4298.0, 
			  0.00004) #0.00015240


import matplotlib.pyplot as plt 

A[0,0] = 0
empirical[0,0] = 0
fig, (ax1, ax2) = plt.subplots(1, 2)
ax1.imshow( np.log(empirical) )
ax1.set_xlabel('West')
ax1.set_ylabel('East')
ax1.set_title("Empirical")

ax2.imshow( np.log(A) )
ax2.set_xlabel('West')
ax2.set_ylabel('East')
ax2.set_title("Expectation")
fig.tight_layout()
plt.savefig('Model2', dpi=1000)