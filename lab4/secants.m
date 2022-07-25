function [xvect,xdif,fx,it_cnt]=secants(a,b,eps,fun)
    xvect = [];
    xdif = [];
    xdif(1) = b;
    fx = [];
    for i = 1:1000
        xVal = feval(fun, b);
        x = b - (xVal*(b - a)/(xVal - feval(fun, a)));
        it_cnt = i;
        xvect(i) = x;
        fx(i) = feval(fun, x);
        if abs(fx(i)) < eps
            for k = 2:length(xvect)
                xdif(k) = abs(xvect(k) - xvect(k - 1));
            end
            return
        end
        a = b;
        b = x;
    end
    
end

