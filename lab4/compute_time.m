function [value] = compute_time(t)
g = 9.81;
m0 = 150000;
q = 2700;
u = 2000;
value = u*log(m0/(m0 - q*t)) - g*t - 750;
end