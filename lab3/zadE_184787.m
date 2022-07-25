clear all
N = [500, 1000, 3000, 6000, 12000];
timeE = zeros(1,5);
precison = 10^(-14);

for i = 1:5
    density = 10;
    [Edges] = generate_network(N(i), density);
    d = 0.85;
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    I = speye(N(i));
    b = (linspace((1 - d)/N(i),(1 - d)/N(i),N(i)))';
    A = speye(N(i));
    for iterator = 1:size(B, 1)
        A(iterator, iterator) = 1/sum(B(:, iterator));
    end
    M = sparse(I - d*B*A);
    D = diag(diag(M));
    L = tril(M, -1);
    U = triu(M, 1);
    r = ones(N(i), 1);

    part1 = -D \ (L + U);
    part2 = D \ b;
    residuum = 1;
    iter(i) = 0;
    tic
    while residuum > precison
        iter(i) = iter(i) + 1;
        r = part1 * r + part2;
        res = M*r - b;
        residuum = norm(res);
        resStore(i, iter(i)) = norm(res);
    end
    timeE(i) = toc;
    clear d B I b A M r
end

plot (N, timeE)
title("time needed to count r depending on matrix size, using Jacobi's method")
xlabel("N - matrix size") 
ylabel("time(N)[s]")
saveas(gcf,'zadE_184787_1.png')

figure()
plot(N, iter)
title("number of iterations depending on matrix size");
ylabel("number of iterations");
xlabel("N - matrix size");
saveas(gcf, 'zadE_184787_2.png');

figure()
semilogy(resStore(2, 1:iter(2)));
title('norm from residuum depending on iteration for N = 1000')
ylabel("norm from residuum");
xlabel("iteration number");
saveas(gcf, 'zadE_184787_3.png');
