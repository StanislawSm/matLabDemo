clc
clear all


%------------------------------------------
load dane_jezioro   % dane XX, YY, FF sa potrzebne jedynie do wizualizacji problemu. 
surf(XX,YY,FF)
shading interp
axis equal
%------------------------------------------
N1 = 0;
for i = 1:10^5
    x = rand() * 100;
    y = rand() * 100;
    z = rand() * -50;
    if z > glebokosc(x, y)
        N1 = N1 + 1;
    end
end
V = 100 * 100 * 50;
result = (N1/(10^5)) * V;
result
