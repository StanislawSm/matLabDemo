function [xvect,xdif,fx,it_cnt]=bisect(a,b,eps,fun)
    xvect = [];
    xdif = [];
    xdif(1) = b;
    fx = [];
    for i = 1:1000
        x = (a + b)/2;
        xVal = feval(fun,x);
        it_cnt = i;
        xvect(i) = x;
        fx(i) = xVal;
        if abs(xVal) < eps || abs(a-b) < eps
            for k = 2:length(xvect)
                xdif(k) = abs(xvect(k) - xvect(k - 1));
            end
            return;
        end
        if feval(fun,a) * xVal < 0
            b = x;
        else
            a = x;
        end
    end
    
end

