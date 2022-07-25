%ex A

edges = sparse([1 1 2 2 2 3 3 3 4 4 5 5 6 6 7;
              4 6 3 4 5 5 6 7 5 6 4 6 4 7 6]);
%ex B

N = 7;
d = 0.85;

% B = sparse([],[],[],N,N);
% for col = 1:size(edges, 2)
%     B(edges(2, col), edges(1, col)) = 1;
% end
B = sparse(edges(2,:), edges(1,:), 1, N, N);
I = speye(N);
b = (linspace((1 - d)/N,(1 - d)/N,N))';
A = speye(N);
for iterator = 1:size(B, 1)
    A(iterator, iterator) = 1/sum(B(:, iterator));
end

%ex C

M = sparse(I - d*B*A);
r = sparse(M\b);

%ex D

bar(r)
title("PR of given sites in given network")
xlabel("site number")
ylabel("PR value")
saveas(gcf,'plotEx1.png')
