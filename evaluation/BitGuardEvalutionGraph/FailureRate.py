import numpy as np
import matplotlib.pyplot as plt

# evenly sampled time at 200ms intervals
f = np.arange(0, 10000000, 100000)

# red dashes, blue squares and green triangles
plt.plot(f,f**f, 'r')
plt.plot(f,2.600834347658729e-16*f**f-2.600834347658729e-11*f+0.0093109869646182, 'r')
plt.show()