import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('historicalData.csv')
dataReversed = df['Close/Last']
mockInput = [1, 2, 3, 4, 5, 6]
data = dataReversed[::-1].reset_index(drop=True)
x = np.arange(0, 1000)


def computingEma(data, period):
    result = pd.Series(index=range(len(data)), dtype='float64')
    alpha = 2 / (period + 1)
    for n in range(period, len(data)):
        tmpSum = 0
        tmpDiv = 0
        for i in range(0, period + 1):
            tmpSum += data[n - i] * pow((1 - alpha), i)
            tmpDiv += pow((1 - alpha), i)
        result.iloc[n] = tmpSum / tmpDiv
    return result


mock = computingEma(mockInput, 2)


def computeMacd(data):
    ema12 = computingEma(data, 12)
    ema26 = computingEma(data, 26)
    macd = pd.Series(index=range(len(data)), dtype='float64')
    for i in range(0, len(data) - 1):
        macd.iloc[i] = ema12[i] - ema26[i]
    signal = computingEma(macd, 9)
    return macd, signal

macd = computeMacd(data)[0]
signal = computeMacd(data)[1]


def simulate(inputPrices, signals, inMacd, inSignal):
    cutSignals = signals[33:]
    money = 0
    units = 1000
    startValue = 1000 * inputPrices[0]
    for i in cutSignals:
        if inMacd[i - 1] < inSignal[i - 1]:
            units += money / inputPrices[i]
            money = 0
        if inMacd[i - 1] > inSignal[i - 1]:
            money += units * inputPrices[i]
            units = 0
        # if differences in macd and signal [i - 1] are to week we do not do anything probably fluctuations

    endValue = units * inputPrices[999] + money
    profit = endValue / startValue
    return profit, endValue, startValue

plt.figure(figsize = (25, 5))
plt.xlabel("period")
plt.ylabel("value")
plt.plot(x, macd, label="macd")
plt.plot(x, signal, label="signal")
plt.legend(loc="upper right")
# plt.plot(data)
signals = np.argwhere(np.diff(np.sign(macd - signal))).flatten()
plt.plot(x[signals], signal[signals], 'rx', label="crossing points")
# for i in signals:
#     if i > 34:
#         plt.axvline(x=i, color='b', label='axvline - full height')
plt.show()

simulationResult = simulate(data, signals, macd, signal)
print("1000 periods profit: ", simulationResult[0])
print("1000 periods final value: ", simulationResult[1])
print("1000 periods initial value: ", simulationResult[2])

simulationResult = simulate(data, signals[35:67], macd, signal)
print("300 periods profit: ", simulationResult[0])
print("300 periods final value: ", simulationResult[1])
print("300 periods initial value: ", simulationResult[2])
