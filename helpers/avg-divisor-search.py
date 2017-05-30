import numpy as np
import math

def make():
    filename = 'out/chvatal-gomory-divisor-search'
    f = open(filename, 'r')
    content = f.read()
    lines = content.split('\n')
    avg = np.zeros(300)
    ref_times = {
        "instances/1.out": 147.68719898,
        "instances/2.out": 35.87421779,
        "instances/3.out": 32.891417732
    }

    for i in range(len(lines)-1):
        data = lines[i].split('\t')
        divisor = int(data[4])
        time = float(data[6])
        instance = data[0]
        if instance == "instances/3.out":
            print(str(divisor) + " " + str(time) + " c")
        avg[divisor] += time
'''
    for i in range(len(avg)):
        avg[i] /= 3
        if avg[i] > 0:
            print(str(i) + "\t" + str(avg[i]))
'''
def main():
    make()

if __name__ == "__main__":
    main()
