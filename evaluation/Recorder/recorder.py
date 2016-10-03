import time
import serial
import numpy as np
flag=True
ser = serial.Serial('/dev/ttyUSB0', 115200)
#ser = serial.Serial('COM2', 115200)
while(ser.isOpen() is False):
    ser.open()
ser.flushInput()
ser.flushOutput()

# start data collection
Buffer = int(ser.readline().rstrip())
print Buffer
while(1):
#while(flag):
    newBuffer =  int(ser.readline().rstrip())
    if (newBuffer == Buffer + 1 ):
        print str(Buffer)+": Correct"
    else:
        print str(Buffer)+": Wrong"
        time.sleep(5)
    Buffer = newBuffer
    #data = ser.readline().rstrip().encode('hex') # read data from serial port and strip line endings
    #data = int(ser.readline().rstrip().encode('hex'),16) # read data from serial port and strip line endings
ser.close()
exit()
