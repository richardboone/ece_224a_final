#python checker for final

import numpy as np
import matplotlib.pyplot as plt
import math

#generate values here:
fs = 2**20                      #oversample clock frequency
ts = 1/fs                      #oversample clock period
num_samples = 1*fs             #number of simulation clock periods
t_stop = (num_samples-1)*ts    #final simulation time

fsig = 1000         #oscillator frequency in Hertz
w = 2*math.pi*fsig/math.sqrt(3)
timearray = np.linspace(start=0, stop=1, num=num_samples)

shift = 24                     #bitshifts in accumulators
bw = 40     




newarray = np.loadtxt("output.txt", dtype='int32', delimiter=',', converters={_:lambda s: int(s, 16) for _ in range(2)});
timearray = np.linspace(start=0, stop=0.1, num=len(newarray))
print(newarray)
plt.plot(timearray, newarray[:,0]);
plt.show()