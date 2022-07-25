dPoly = zeros(1, 45);
dTrig = zeros(1, 45);

for i = 5:45
  [YY,XX]=meshgrid(linspace(0,100,101),linspace(0,100,101));
  [x,y,f] = lazik(i);

  [p] = polyfit2d(x,y,f);
  [FFp]=polyval2d(XX,YY,p);

  [p] = trygfit2d(x,y,f);
  [FFt]=trygval2d(XX,YY,p);
  
  if i == 5
    FFpPrev = FFp(1);
    FFtPrev = FFt(1);
  else
    dPoly(i) = max(max(abs(FFp-FFpPrev)));
    dTrig(i) = max(max(abs(FFt-FFtPrev)));
    FFpPrev = FFp;
    FFtPrev = FFt;
  end
end

plot(6:45, dPoly(6:45));
title("Convergence of polynominal interpolation");
ylabel("Maximal value of differences of functions");
xlabel("Number of points - K");
print ("convergancePolInter.png", '-dpng', '-r580')

plot(6:45, dTrig(6:45));
title("Convergence of trigonometric interpolation");
ylabel("Maximal value of differences of functions");
xlabel("Number of points - K");
print ("converganceTrigInter.png", '-dpng', '-r580')

