import LU


def createZerosMatrix(m, n):
    result = []
    for i in range(m):
        row = [0] * n
        result.append(row)
    return result


def SplineInter(X, Y):
    def prepareEquations():
        n = len(X)
        mSize = 4 * (n - 1)
        A = createZerosMatrix(mSize, mSize)
        b = [0] * mSize

        # Si(xj) = f(xj)
        for i in range(n - 1):
            y = Y[i]
            row = [0] * mSize
            row[4 * i + 3] = 1  # a
            A[4 * i + 3] = row
            b[4 * i + 3] = (float(y))

        # Sj(Xj+1) = f(Xj+1)
        for i in range(n - 1):
            x1, y1 = X[i + 1], Y[i + 1]
            x0 = X[i]
            h = float(x1) - float(x0)
            row = [0] * mSize
            row[4 * i] = h ** 3         # d
            row[4 * i + 1] = h ** 2     # c
            row[4 * i + 2] = h ** 1     # b
            row[4 * i + 3] = 1          # a
            A[4 * i + 2] = row
            b[4 * i + 2] = float(y1)

        # for inner points, Sj-1'(xj) = Sj'(xj)
        for i in range(n - 2):
            x1 = X[i + 1]
            x0 = X[i]
            h = float(x1) - float(x0)
            row = [0] * mSize
            row[4 * i] = 3 * (h ** 2)   # d
            row[4 * i + 1] = 2 * h      # c
            row[4 * i + 2] = 1          # b0
            row[4 * (i + 1) + 2] = -1   # b1
            A[4 * i] = row
            b[4 * i] = float(0)

        # for inner points, Sj-1''(xj) = Sj''(xj)
        for i in range(n - 2):
            x1 = X[i + 1]
            x0 = X[i]
            h = float(x1) - float(x0)
            row = [0] * mSize
            row[4 * i] = 6 * h          # d
            row[4 * i + 1] = 2          # c0
            row[4 * (i + 1) + 1] = -2   # c1
            A[4 * (i + 1) + 1] = row
            b[4 * (i + 1) + 1] = float(0)

        # S0''(x0) = 0
        row = [0] * mSize
        row[1] = 1          # c0
        A[1] = row
        b[1] = float(0)

        # Sn-1''(xn-1) = 0
        row = [0] * mSize
        x1 = X[-1]
        x0 = X[-2]
        h = float(x1) - float(x0)
        row[1] = 2          # c
        row[-4] = 6 * h     # d
        A[-4] = row
        b[-4] = float(0)

        result = LU.luFactorization(A, b)
        return result

    params = prepareEquations()

    def f(x):
        param_array = []
        row = []
        for param in params:
            row.append(param)
            if len(row) == 4:
                param_array.append(row.copy())
                row.clear()

        for i in range(1, len(X)):
            xi, yi = X[i - 1], Y[i - 1]
            xj, yj = X[i], Y[i]
            if float(xi) <= x <= float(xj):
                a, b, c, d = param_array[i-1]
                h = x - float(xi)
                return a*(h**3)+b*(h**2)+c*h+d

        return yj

    return f
