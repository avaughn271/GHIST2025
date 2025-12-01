import msprime
import numpy as np
import pandas
df = pandas.read_csv("sampledvalues_hapNE.txt", header=None, delimiter=' ')


#print(df)
for index, row in df.iterrows():
    value1 = row[0]
    value2 = row[1]
    value3 = row[2]


    # --- Fixed simulation settings ---
    sample_size = 3
    seq_length = 10000000
    mu = 1.4e-8
    recomb_rate = 1.5e-8

    N_recent = value1 / 2
    SPLIT = value3
    N_ancestral= value2 / 2
    demography = msprime.Demography()
    demography.add_population(name="wisent", initial_size = N_recent)
    demography.add_population_parameters_change(time = SPLIT, initial_size = N_ancestral, population=0)

    ts = msprime.sim_ancestry(samples=sample_size, demography=demography, 
                                sequence_length=seq_length,
                                recombination_rate=recomb_rate )
    ts = msprime.sim_mutations(ts, rate=mu)
    with open("Training/" + str(int(value1)) +"_" + str(int(value2)) +"_"+ str(int(value3)) + ".vcf", "w") as vcf_file:
        ts.write_vcf(vcf_file)