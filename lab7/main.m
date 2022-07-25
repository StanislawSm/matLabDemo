load P_ref.mat
Y = [];
for x = 1:20
    Y = [Y, prob(x)];
end

plot(1:20, Y)
title('prob(x)')
xlabel('years')
ylabel('probability')

N = 5 : 50 : 10^4;

% rectangles method
rectanglesError = [];
for n = N
    sum = 0;
    dx = 5/n;
    xi = 0;
    for n = 1:n
        a = prob((2*xi + dx)/2);
        sum = sum + a*dx;
        xi = xi + dx;
    end
    rectanglesError = [rectanglesError, abs(sum - P_ref)];
end
loglog(N, rectanglesError)
title('error for rectangles method')
xlabel('N')
ylabel('error')
saveas(gcf, 'recMethodErr.png')

% trapeze method
trapError = [];
for n = N
    sum = 0;
    dx = 5/n;
    xi = 0;
    for n = 1:n
        a = prob(xi+dx);
        b = prob(xi);
        sum = sum + ((a+b)/2)*dx;
        xi = xi+dx;
    end
    trapError = [trapError, abs(sum - P_ref)];
end
loglog(N, trapError)
title('error for trapeze method')
xlabel('N')
ylabel('error')
saveas(gcf, 'trapMethodErr.png')

% Simpson method
simError = [];
for n = N
    sum = 0;
    dx = 5/n;
    xi = 0;
    for n = 1:n
        a = prob(xi+dx);
        b = prob(xi);
        c = prob((xi + xi + dx)/2);
        sum = sum + (dx/6) * (a + b + 4*c);
        xi = xi + dx;
    end
    simError = [simError, abs(sum - P_ref)];
end
loglog(N, simError)
title('error for Simpson method')
xlabel('N')
ylabel('error')
saveas(gcf, 'simMethodErr.png')

% Monte Carlo method
mcErr = [];
fmax = prob(5);
for n = N
    N1 = 0;
    for i = 1:n
        x = rand() * 5;
        y = rand() * fmax;
        if y < prob(x)
            N1 = N1+1;
        end
    end
    S = fmax * 5;
    res = N1/n * S;
    mcErr = [mcErr, abs(res - P_ref)];
end
loglog(N, mcErr)
title('error for Monte Carlo method')
xlabel('N')
ylabel('error')
saveas(gcf, 'mcMethodErr.png')





% times
N = 10^7;

% rectangles
tic
xi = 0;
dx = 5/N;
sum = 0;
for i = 1:N
    a = prob((2*xi + dx)/2);
    sum = sum + a * dx;
    xi = xi + dx;
end
recTime = toc;

% trapeze
tic
xi = 0;
dx = 5/N;
sum = 0;
for i = 1:N
    a = prob(xi+dx);
    b = prob(xi);
    sum = sum + ((a+b)/2)*dx;
    xi = xi + dx;
end
trTime = toc;

% Sipmson
tic
xi = 0;
dx = 5/N;
sum = 0;
for i = 1:N
    a = prob(xi+dx);
    b = prob(xi);
    c = prob((xi + xi + dx)/2);
    sum = sum + (dx/6) * (a + b + 4*c);
    xi = xi + dx;
end
simTime = toc;

% Monte Carlo
tic
fmax = prob(5);
N1 = 0;
for i = 1:N
    x = rand() * 5;
    y = rand() * fmax;
    if y < prob(x)
        N1 = N1+1;
    end
end
S = fmax * 5;
sum = N1 / N * S;
mcTime = toc;

%plot
x = categorical({'rectangles method', 'trapeze method', 'Simpsons method', 'Monte Carlo method'});
bar(x, [recTime, trTime, simTime, mcTime]);
title("times needed to compute solution with various methods");
xlabel("method name");
ylabel("time [s]");
saveas(gcf, "times.png");