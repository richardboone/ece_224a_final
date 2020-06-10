#getvalues.py
import math

fs = 2**24                      #oversample clock frequency
ts = 1/fs                      #oversample clock period
num_samples = 1*fs             #number of simulation clock periods
t_stop = (num_samples-1)*ts    #final simulation time

fsig = 1000         #oscillator frequency in Hertz
w = (2*math.pi*fsig/(math.sqrt(3))) * (3.0/2.0)

shift = 24                     #bitshifts in accumulators
bw = 40                        #bitwidth of accumulator registers

w = w* 2**16
print("W: %x" % (int(w)))
