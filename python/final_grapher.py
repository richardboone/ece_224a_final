#python checker for final

import numpy as np
import matplotlib.pyplot as plt
import math

#generate values here:
# fs = 2**25                      #oversample clock frequency
fs = 10**7                      #oversample clock frequency
ts = 1/fs                      #oversample clock period
num_samples = 1*fs             #number of simulation clock periods
t_stop = (num_samples-1)*ts    #final simulation time

fsig = 1000         #oscillator frequency in Hertz
w = 2*math.pi*fsig/math.sqrt(3)
timearray = np.linspace(start=0, stop=1, num=num_samples)

shift = 24                     #bitshifts in accumulators
bw = 40     




# newarray = np.loadtxt("output.txt", dtype='int32', delimiter=',', converters={_:lambda s: int(s, 16) for _ in range(2)});
# print(len(newarray))
# newarray = newarray[200000:]
# timearray = np.linspace(start=0.02, stop=0.045, num=len(newarray))
newarray = np.loadtxt("output.txt", dtype='int32', delimiter=',', converters={_:lambda s: int(s, 16) for _ in range(2)});
print(len(newarray))
timearray = np.linspace(start=0, stop=0.2, num=len(newarray))
print(newarray)
plt.plot(timearray, newarray[:,0]);
# plt.plot(timearray, newarray[:,1]);
plt.show()
# plt.plot(timearray, newarray[:, 1]);
# plt.show()

spectrum = np.fft.fft(a=newarray[:,0])
# spectrum2 = np.fft.fft(a=newarray[:,1])
freq = np.fft.fftfreq(len(newarray))*fs
plt.plot(freq, abs(spectrum))
# plt.plot(freq, abs(spectrum2))
plt.yscale("log")
plt.show()

print(fs, "40'h00088b2f70", abs(freq[np.argmax(spectrum)]))
print(freq[np.argmax(spectrum)])
# for i in range(len(spectrum)):
    # max`