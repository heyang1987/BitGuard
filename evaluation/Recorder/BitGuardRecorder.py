import serial
import numpy as np
import matplotlib.pyplot as plt

ser = serial.Serial('/dev/ttyUSB0', 115200)
ser.close()
ser.open()

out = ser.readline()
print out
plt.ion() # set plot to animated
 
ydata = [0] * 50
ax1=plt.axes()  
 
# make plot
line, = plt.plot(ydata)
plt.ylim([10,40])
 
# start data collection
while(1):
    data = int(ser.readline().rstrip().encode('hex'),16) # read data from serial port and strip line endings
    #data = 4351-int(data_raw.encode('hex'),16)
    #if len(data.split(".")) == 2:
    plt.ylim([0,200])
    print data
    ydata.append(data)
    #del ydata[0]
    line.set_xdata(np.arange(len(ydata)))
    line.set_ydata(ydata)  # update the data
    plt.draw() # update the plot