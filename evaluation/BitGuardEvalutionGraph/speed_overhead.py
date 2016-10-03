import matplotlib.pyplot as plt
import numpy as np
array = ('Delay','Double Funtion Calls','Fibonacci')

ind = np.arange(3)  # the x locations for the groups
width=0.2
plt.bar(0.7,1393.5,width,color='orange')
plt.bar(0.9,1522.6,width,color='yellow',hatch="//")
plt.bar(1.1,1551.8,width,color='green',hatch="\\")

plt.bar(1.7,38.6,width,color='orange')
plt.bar(1.9,449.2,width,color='yellow',hatch="//")
plt.bar(2.1,530,width,color='green',hatch="\\")

plt.bar(2.7,1668,width,color='orange',label='Original')
plt.bar(2.9,4506,width,color='yellow',label='No Recovery',hatch="//")
plt.bar(3.1,5021,width,color='green',label='Recovery',hatch="\\")

plt.xticks(ind+1,array)
plt.yticks(np.arange(0,5600,400))
plt.ylabel('Execution Time (us)')
plt.legend(loc='upper left')
plt.show()