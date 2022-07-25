import copy


def createOnesMatrix(N):
    result = []
    for i in range(N):
        row = []
        for j in range(N):
            if i == j:
                row.append(1)
            else:
                row.append(0)
        result.append(row)
    return result


def dotProduct(A, b):
    n = len(A)
    result = [0] * n
    for i in range(n):
        for j in range(n):
            result[i] += b[j] * A[i][j]
    return result


def luDecomposition(A):
    U = copy.deepcopy(A)
    L = createOnesMatrix(len(A))
    for k in range(0, len(A)):
        for j in range(k + 1, len(A)):
            L[j][k] = U[j][k] / U[k][k]
            for i in range(k, len(A)):
                U[j][i] = U[j][i] - L[j][k] * U[k][i]
    return L, U


def forwardSubstitution(L, b):
    n = len(L)
    x = [0] * n
    for i in range(0, n):
        value = b[i]
        for j in range(0, i):
            value -= L[i][j] * x[j]
        x[i] = value / L[i][i]
    return x


def backwardSubstitution(U, y):
    n = len(U)
    x = [0] * n
    for i in range(n - 1, -1, -1):
        value = y[i]
        for j in range(i, n):
            value -= U[i][j] * x[j]
        x[i] = value / U[i][i]
    return x


def luFactorization(A, b):
    L, U = luDecomposition(A)
    y = forwardSubstitution(L, b)
    x = backwardSubstitution(U, y)
    return x
