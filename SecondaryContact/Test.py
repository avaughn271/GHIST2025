import numpy as np
import msprime
from scipy.optimize import minimize
from numpy import genfromtxt
from math import log10

mu = 8.4 * (10**-8)
L = 10000000  # from 100000000
numberofunits = 50
repitations =  2  # from 25
empirical = genfromtxt('Test.csv', delimiter=' ')
empirical = empirical / np.sum(empirical)

mainlandids = []
for i in range(0,24 * 2):
	mainlandids.append(i)
islandids = []
for i in range(24 * 2, 24 * 2 + 11 * 2):
	islandids.append(i)

def kl(E, X):
	test1 = 0

	largesum = 0
	for i in range(24*2):
		for j in range(11 * 2):
			if E[i,j] > 0 and X[i,j] > 0:
				largesum = largesum + X[i,j] * np.log(X[i,j]  / E[i,j])
				test1 = test1 +  X[i,j] 
			if E[i,j] <= 0 and X[i,j] > 0:
				print(i,j, X[i,j])
				largesum = largesum + X[i,j] * (np.log(X[i,j]) + 30.0  )
	print("test", test1)
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

def getvalue(N_main, N_island,  N_ancestral, T_split, T_mig, migrate1):
	SFSFULL = np.zeros((24*2+1,11*2 + 1))
	for _ in range(repitations):
		SFS = np.zeros((24*2+1,11*2 + 1))
		tre = getTrees(N_main, N_island,  N_ancestral, T_split, T_mig, migrate1)
		totalmut = 0

		for ts in tre:
			mts = msprime.sim_mutations(ts, rate=mu  , model = "binary")
			totalmut = totalmut + np.sum(mts.allele_frequency_spectrum([mainlandids, islandids], mode='site', polarised=True, span_normalise = False))
			SFS = SFS + mts.allele_frequency_spectrum([mainlandids, islandids], mode='branch', polarised=True, span_normalise = False)
		SFS = np.divide(SFS, np.divide(np.sum(SFS)  , totalmut) )

		SFS[0,0]  = L - np.sum(SFS)
		SFS = np.divide(SFS, L)
		SFSFULL = np.add(SFSFULL , SFS)
	return kl(np.divide(SFSFULL , repitations), empirical)

def negloglieklihoodfunction(args):
	migrate1= 10**args[0]
	T_mig= 10**args[1]
	N_island= 10**args[2]
	N_main = 10**args[3]
	T_split= 10**args[4]
	N_ancestral= 10**args[5]


	if T_split < T_mig: return(100000000000.00)

	A = getvalue(N_main, N_island,  N_ancestral, T_split, T_mig, migrate1)
	print(N_main, N_island,  N_ancestral, T_split, T_mig, migrate1, A)

	return((A*100000)**2)



###158587.88381172245 12510.563007622779 59767.92400554957 22703.453431752845 386.0220635980289 0.0001846611305000167 0.000143957561428617 3.145153996304689e-05
### with 25 reps


opts = {}
opts['maxfev'] = 250
#opts['initial_simplex']=Simplex
res = minimize(negloglieklihoodfunction,  [log10( 0.00015240), 
										   	log10(4298.0), # mig time
										   log10(49213.00), #island size
										   	log10(15380.0),  #mainland size
											  log10(13350.0),  #split time time
											  log10( 5970.92400554957 )  #ancestral size
											 ], method='Nelder-Mead', options = opts)
print(10**res.x)


# 0.0010738644180092963