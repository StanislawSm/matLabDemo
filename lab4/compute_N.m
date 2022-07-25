function [value] = compute_N(N)
    value = (power(N, 1.43) + power(N, 1.14))/1000 - 5000;
end