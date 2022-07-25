%ex A

N = 10;
density = 3;
[Edges] = generate_network(N, density);

%ex B

d = 0.85;

B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
I = speye(N);
b = (linspace((1 - d)/N,(1 - d)/N,N))';
A = speye(N);
for iterator = 1:size(B, 1)
    A(iterator, iterator) = 1/sum(B(:, iterator));
end

save zadB_184787 A B I b

%ex C

M = sparse(I - d*B*A);
r = sparse(M\b);

save zadC_184787 r

%ex D

clear all
N = [500, 1000, 3000, 6000, 12000];
timeD = zeros(1,5);

for i = 1:5
    density = 3;
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
    tic
    r = sparse(M\b);
    timeD(i) = toc;
    clear d B I b A M r
end

plot (N, timeD)
title("time needed to count r exercise D")
xlabel("N - matrix size") 
ylabel("time(N)[s]")
saveas(gcf,'zadD_184787.png')





