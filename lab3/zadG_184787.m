clear all
load("Dane_Filtr_Dielektryczny_lab3_MN.mat")
precison = 10^(-14);

D = diag(diag(M));
L = tril(M, -1);
U = triu(M, 1);

disp(issparse(M))

% Jacobi

tic

part1 = -D \ (L + U);
part2 = D \ b;
residuum = 1;
r = ones(size(M,2), 1);

while residuum > precison
    r = part1 * r + part2;
    res = M*r - b;
    residuum = norm(res);
    if(isnan(residuum))
        disp("Jacobi's method failed")
        break
    end
end
if(not(isnan(residuum)))
    disp("Jacobi's method succeeded")
end

disp(toc)

% Gauss-Seidel

tic

part1 = -(D + L);
part2 = (D + L) \ b;
residuum = 1;
r = ones(size(M,2), 1);

while residuum > precison
    r = part1\(U*r) + part2;
    res = M*r - b;
    residuum = norm(res);
    if(isnan(residuum))
        disp("Gauss-Seidel method failed")
        break
    end
end
if(not(isnan(residuum)))
    disp("Gauss-Seidel method succeeded")
end

disp(toc)
% direct method
tic
r = sparse(M\b);
disp(toc)