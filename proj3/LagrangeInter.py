def LagrangeInter(X, Y):
    def f(x):
        result = 0
        n = len(X)
        for i in range(n):
            xi, yi = X[i], Y[i]
            base = 1
            for j in range(n):
                if i == j:
                    continue
                else:
                    xj, yj = X[j], Y[j]
                    base *= (float(x) - float(xj))/float(float(xi) - float(xj))
            result += float(yi) * base
        return result
    return f
