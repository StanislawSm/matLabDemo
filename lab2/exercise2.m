% parameters initialization
a = 1;
nMax = 50000;
rMax = 0.2;
limits = [0 a 0 a];
n = 1;
x = zeros(nMax, 1);
y = zeros(nMax, 1);
r = zeros(nMax, 1);
area = zeros(nMax, 1);
trials = zeros(nMax, 1);

%main loop
while n <= nMax
    
    newX = mod(rand(), a);
    newY = mod(rand(), a);
    newR = mod(rand(), rMax);
    trials(n) = trials(n) + 1;
    fits = false;
    if (newX - newR >= 0 && newX + newR <= a && newY - newR >= 0 && newY + newR <= a)
        fits = true;
    end
    %checking if new circle is colliding with existing one
    if n > 1
        for i = 1:n
            xD = (x(i) - newX) * (x(i) - newX);
            yD = (y(i) - newY) * (y(i) - newY);
            if (sqrt(xD + yD) <= (r(i) + newR))
                fits = false;
                break;
            end
        end
    end
    
    %ploting
    if fits
%         movegui([0 100])
%         plotCircle(newX, newY, newR)
%         title(sprintf('n = %.0f', n))
%         axis equal
%         axis(limits)
%         hold on
        x(n) = newX;
        y(n) = newY;
        r(n) = newR;
        if n > 1
            area(n) = pi*newR*newR + area(n - 1);
        else
            area(n) = pi*newR*newR;
        end
        fprintf(1, ' %s%5d%s%.3g\r ', 'n =', n, ' S = ', area(n))
        n = n + 1;
        %pause(0.05)
    end
    
end


set(gcf,'position',[0,0,800,800])
for i = 1:nMax
    plotCircle(x(i), y(i), r(i))
    hold on
end
title(sprintf('nMax = %.0f', nMax))
axis equal
axis(limits)


% hold off
% figure(2)
% movegui([500 100])
% semilogx(area)
% title("sum of area")
% xlabel("n")
% ylabel("area sum")
% saveas(gcf,'plotEx2.1.png')
% 
% figure(3)
% movegui([1000 100])
% dra = cumsum(trials)./(1:nMax)';
% loglog(dra)
% title("average amount of trials")
% xlabel("n")
% ylabel("trials")
% saveas(gcf,'plotEx2.2.png')