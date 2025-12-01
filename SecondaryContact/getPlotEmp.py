import numpy as np
import msprime
import pandas
from scipy.optimize import minimize
from numpy import genfromtxt
from math import log10

empirical = genfromtxt('Test.csv', delimiter=' ')
Test = empirical / np.sum(empirical)


empirical = genfromtxt('Final.csv', delimiter=' ')
Final = empirical / np.sum(empirical)


import matplotlib.pyplot as plt 

Test[0,0] = 0
Final[0,0] = 0
fig, (ax1, ax2) = plt.subplots(1, 2)
ax1.imshow( np.log(Test) )
ax1.set_xlabel('Main')
ax1.set_ylabel('Island')
ax1.set_title("Test")

ax2.imshow( np.log(Final) )
ax2.set_xlabel('Main')
ax2.set_ylabel('Island')
ax2.set_title("Final")
fig.tight_layout()
plt.savefig('Model', dpi=1000)