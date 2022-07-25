dK = [5, 15, 25, 33];
[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));

for i = K
  [x,y,f,xp, yp] = lazik(i);

  subplot(2,2,1)
  plot(xp,yp,'-o','linewidth',3, 'MarkerSize', 1);
  title("Rover path for K = " + i);
  ylabel("y[m]");
  xlabel("x[m]");
  grid on
  grid minor
  
  subplot(2,2,2);
  plot3(x,y,f,'o','MarkerSize', 1);
  title("Values of samples for K = " + i);
  ylabel("y[m]");
  xlabel("x[m]");
  zlabel("f(x,y)");
  grid on
  grid minor
  
  [p] = polyfit2d(x,y,f);
  [FF]=polyval2d(XX,YY,p);
  subplot(2,2,3);
  surf(YY,XX,FF);
  title("Polynominal interpolation for K = " + i);
  ylabel("y[m]");
  xlabel("x[m]");
  zlabel("f(x,y)");
  grid on
  grid minor
  shading flat
  
  [p] = trygfit2d(x,y,f);
  [FF]=trygval2d(XX,YY,p);
  subplot(2,2,4);
  surf(YY,XX,FF);
  title("Trigonometric interpolation for K = " + i);
  ylabel("y[m]");
  xlabel("x[m]");
  zlabel("f(x,y)");
  grid on
  grid minor
  shading flat
  
  print (("K_" + i + ".png"), '-dpng', '-r580')

end