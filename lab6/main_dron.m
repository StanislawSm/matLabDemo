clc
clear all
close all

load trajektoria1;

plot3(x,y,z,'o');
grid on;
axis equal;
title("Real trajectory 1");
xlabel("x")
ylabel("y");
zlabel("z");
print (gcf, "184787_Smykowski_zad2.png", "-dpng", "-r400")
hold on  

N = 50;
[wsp_wielX, xa] = aproksymacjaWiel(n,x,N);  % aproksymacja wsp. 'x'
[wsp_wielY, ya] = aproksymacjaWiel(n,y,N);  % aproksymacja wsp. 'y'
[wsp_wielZ, za] = aproksymacjaWiel(n,z,N);  % aproksymacja wsp. 'z'
title("Real trajectory 1 with polynominal aproximation for N = 50");

plot3(xa,ya,za, "LineWidth", 4);
print (gcf, "184787_Smykowski_zad4.png", "-dpng", "-r400")

% zad5

clc
clear all
close all

load trajektoria2;

plot3(x,y,z,'o');
grid on;
axis equal;
title("Real trajectory 2 with polynominal aproximation for N = 60");
xlabel("x")
ylabel("y");
zlabel("z");    
hold on  

N = 60;
[wsp_wielX, xa] = aproksymacjaWiel(n,x,N);  % aproksymacja wsp. 'x'
[wsp_wielY, ya] = aproksymacjaWiel(n,y,N);  % aproksymacja wsp. 'y'
[wsp_wielZ, za] = aproksymacjaWiel(n,z,N);  % aproksymacja wsp. 'z'
plot3(xa,ya,za, "LineWidth", 4);
print (gcf, "184787_Smykowski_zad5.png", "-dpng", "-r400")
hold off

err = [];
Mvec = size(n);
M = Mvec(2);
for i = 1:71
  N = i;
  [wsp_wielX, xa] = aproksymacjaWiel(n,x,N);  % aproksymacja wsp. 'x'
  [wsp_wielY, ya] = aproksymacjaWiel(n,y,N);  % aproksymacja wsp. 'y'
  [wsp_wielZ, za] = aproksymacjaWiel(n,z,N);  % aproksymacja wsp. 'z'

  errx = sqrt(sum((x - xa).^2)) / M;
  erry = sqrt(sum((y - ya).^2)) / M;
  errz = sqrt(sum((z - za).^2)) / M;

  err(i) = errx + erry + errz;
end
semilogy(err);
title("Polynominal aproximation error");
xlabel("N");
ylabel("arror value");
print (gcf, '184787_Smykowski_zad5_b.png', '-dpng', '-r400')

% zad 7

clc
clear all
close all

load trajektoria2;

plot3(x,y,z,'o');
grid on;
axis equal;
title("Real trajectory 2 with trigonometric aproximation for N = 60");
xlabel("x")
ylabel("y");
zlabel("z");    
hold on  

N = 60;
xa = aprox_tryg(n,x,N);  % aproksymacja wsp. 'x'
ya = aprox_tryg(n,y,N);  % aproksymacja wsp. 'y'
za = aprox_tryg(n,z,N);  % aproksymacja wsp. 'z'
plot3(xa,ya,za, "LineWidth", 4);
print (gcf, "184787_Smykowski_zad7.png", "-dpng", "-r400")
hold off

err = [];
Mvec = size(n);
M = Mvec(2);
for i = 1:71
  N = i;
  xa = aprox_tryg(n,x,N);  % aproksymacja wsp. 'x'
  ya = aprox_tryg(n,y,N);  % aproksymacja wsp. 'y'
  za = aprox_tryg(n,z,N);  % aproksymacja wsp. 'z'

  errx = sqrt(sum((x - xa).^2)) / M;
  erry = sqrt(sum((y - ya).^2)) / M;
  errz = sqrt(sum((z - za).^2)) / M;

  err(i) = errx + erry + errz;
end
semilogy(err);
title("trigonometric aproximation error");
xlabel("N");
ylabel("arror value");
print (gcf, '184787_Smykowski_zad7_b.png', '-dpng', '-r400')

% mine implementation of best N

% N = min(err);
tres = 10^-3;
err = 1;
N = 0;
while err > tres
    N = N + 1;
    xa = aprox_tryg(n,x,N);  % aproksymacja wsp. 'x'
    ya = aprox_tryg(n,y,N);  % aproksymacja wsp. 'y'
    za = aprox_tryg(n,z,N);  % aproksymacja wsp. 'z'

    errx = sqrt(sum((x - xa).^2)) / M;
    erry = sqrt(sum((y - ya).^2)) / M;
    errz = sqrt(sum((z - za).^2)) / M;

    err = errx + erry + errz;
end

xa = aprox_tryg(n, x, N);
ya = aprox_tryg(n, y, N);
za = aprox_tryg(n, z, N);

plot3(x,y,z,'o');
grid on;
axis equal;
title("Real trajectory 2 with trigonometric aproximation for best N");
xlabel("x")
ylabel("y");
zlabel("z");    
hold on  
plot3(xa,ya,za, "LineWidth", 4);
hold off
            