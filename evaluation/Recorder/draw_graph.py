'''
Created on Dec 10, 2013

@author: yang
'''
import matplotlib.pyplot as plt
import matplotlib
font = {'family' : 'normal',
        'size'   : 30}
matplotlib.rc('font', **font)
f1 = open("result1.txt","r")      # optimal scheduler
f2 = open("result2.txt","r")      # optimal scheduler
f3 = open("result3_v2.txt","r")      # optimal scheduler
i=1
y1 = []
y2 = []
y3 = []
while(i<=3000):
    line1 = f1.readline().rstrip()
    line2 = f2.readline().rstrip()
    line3 = f3.readline().rstrip()
    y1.append(int(line1)-22)
    y2.append(int(line2)-22)
    y3.append(int(line3)-22)
    i = i+1
#y = s1.split("\n")
x = 1
t = []
while(x <= len(y3)):
    t.append(x)
    x = x + 1
plt.plot(t,y1,'r',label = 'Fibonacci')
plt.plot(t,y2,'b:',linewidth=1.4,label = 'Double Function Calls')
plt.plot(t,y3,'g-.', label = 'Delay')
plt.axis([0,len(t),0,100])
plt.xlabel("Time (us)", fontsize=30)
plt.ylabel("Stack Size (bytes)", fontsize=30)
plt.legend(loc='upper right', fontsize=24)
plt.savefig("stacksize_usage_v3.pdf",bbox_inches=0,format='pdf')
plt.show()