

[xvect, xdif, fx, it_cnt] = bisect(1,60000,1e-3,@compute_N);
semilogy(1:it_cnt, xvect)
title("Problem 1: value of aproximations depending on iteration with bisection method");
ylabel("value of N");
xlabel("iteration number");
saveas(gcf, 'Pr1AproxBisec.png');

plot(1:it_cnt, xdif)
title("Problem 1: value of differences depending on iteration with bisection method");
ylabel("value of differences between N");
xlabel("iteration number");
saveas(gcf, 'Pr1DiffBisec.png');

[xvect, xdif, fx, it_cnt] = secants(1,60000,1e-3,@compute_N);
semilogy(1:it_cnt, xvect)
title("Problem 1: value of aproximations depending on iteration with secants method");
ylabel("value of N");
xlabel("iteration number");
saveas(gcf, 'Pr1AproxSecants.png');

plot(1:it_cnt, xdif)
title("Problem 1: value of differences depending on iteration with secants method");
ylabel("value of differences between N");
xlabel("iteration number");
saveas(gcf, 'Pr1DiffSecants.png');

%--------------------------------------------------------------------------

[xvect, xdif, fx, it_cnt] = bisect(0,50,1e-12,@compute_impedance);
semilogy(1:it_cnt, xvect)
title("Problem 2: value of aproximations depending on iteration with bisection method");
ylabel("value of radial velocity [rad/s]");
xlabel("iteration number");
saveas(gcf, 'Pr2AproxBisec.png');

plot(1:it_cnt, xdif)
title("Problem 2: value of differences depending on iteration with bisection method");
ylabel("value of differences between radial velocity [rad/s]");
xlabel("iteration number");
saveas(gcf, 'Pr2DiffBisec.png');

[xvect, xdif, fx, it_cnt] = secants(0,50,1e-12,@compute_impedance);
semilogy(1:it_cnt, xvect)
title("Problem 2: value of aproximations depending on iteration with secants method");
ylabel("value of radial velocity [rad/s]");
xlabel("iteration number");
saveas(gcf, 'Pr2AproxSecants.png');

plot(1:it_cnt, xdif)
title("Problem 2: value of differences depending on iteration with secants method");
ylabel("value of differences between radial velocity [rad/s]");
xlabel("iteration number");
saveas(gcf, 'Pr2DiffSecants.png');

%--------------------------------------------------------------------------

[xvect, xdif, fx, it_cnt] = bisect(0,50,1e-12,@compute_time);
semilogy(1:it_cnt, xvect)
title("Problem 3: value of aproximations depending on iteration with bisection method");
ylabel("value of time [s]");
xlabel("iteration number");
saveas(gcf, 'Pr3AproxBisec.png');

plot(1:it_cnt, xdif)
title("Problem 3: value of differences depending on iteration with bisection method");
ylabel("value of differences between time [s]");
xlabel("iteration number");
saveas(gcf, 'Pr3DiffBisec.png');

[xvect, xdif, fx, it_cnt] = secants(0,50,1e-12,@compute_time);
semilogy(1:it_cnt, xvect)
title("Problem 3: value of aproximations depending on iteration with secants method");
ylabel("value of time [s]");
xlabel("iteration number");
saveas(gcf, 'Pr3AproxSecants.png');

plot(1:it_cnt, xdif)
title("Problem 3: value of differences depending on iteration with secants method");
ylabel("value of differences between time [s]");
xlabel("iteration number");
saveas(gcf, 'Pr3DiffSecants.png');

%--------------------------------------------------------------------------

options = optimset('Display','iter');
fzero(@tan,6,options)
fzero(@tan,4.5,options)


