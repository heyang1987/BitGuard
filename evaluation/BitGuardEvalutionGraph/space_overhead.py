import matplotlib.pyplot as plt
import numpy as np
array = ('Delay','Double Funtion Calls','Fibonacci')

ind = np.arange(3)  # the x locations for the groups
width=0.2

plt.bar(0.8,871,width,color='orange',hatch="//")
plt.bar(1,1412,width,color='green')


plt.bar(1.8,972,width,color='orange',hatch="//")
plt.bar(2,2076,width,color='green')

plt.bar(2.8,838,width,color='orange',label='Original',hatch="//")
plt.bar(3,1379,width,color='green',label='Modified')

plt.xticks(ind+1,array)
plt.yticks(np.arange(0,2200,400))
plt.ylabel('ROM Size (bytes)')
plt.legend(loc='upper left')
plt.show()