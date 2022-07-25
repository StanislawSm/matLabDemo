import csv
import matplotlib.pyplot as plt
import LagrangeInter
import SplineInter


def loadFileIntoVectors(fileName):
    file = open('./data/'+fileName+'.csv', 'r')
    loadedData = list(csv.reader(file))
    data = loadedData[1:]

    Y = []
    X = []

    for i in range(len(data)):
        X.append(float(data[i][0]))
        Y.append(float(data[i][1]))
    return X, Y


X, Y = loadFileIntoVectors('Obiadek')
dataToInterX = X[0::22]
dataToInterY = Y[0::22]

F = SplineInter.SplineInter(dataToInterX, dataToInterY)
interY = []
for point in X:
    interY.append(float(F(point)))

plt.semilogy(dataToInterX, dataToInterY, 'bx')
plt.semilogy(X, Y, 'b-')
plt.semilogy(X, interY, 'r-')
plt.show()


