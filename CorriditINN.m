% 2025-05-29
x = meanW';        # количество затраченного топлива
y =  mid(RestINNarray);        # объем произведенного пара
epsilon = rad(RestINNarray);  # верхняя граница ошибки для y_i
indNaN  = isnan(mid(RestINNarray))
x(indNaN) = []
y(indNaN) = []
epsilon(indNaN) = []
infy = y - epsilon
supy = y + epsilon

X = [ x.^0 x ];                               # матрица значений переменных при beta1 и beta2
%
[tolmax,argmax, env] = tolsolvty(X,X,infy',supy',1);
for ii=1:length(X)
  ytolmax(ii) = argmax(1) + argmax(2)*X(ii, 2)
end
figure
hold on
errorbar(x, y, epsilon,"~.r");
plot(x, ytolmax,'sr')
plot(x, ytolmax,'-r')

% tol_i > 0
tolpos = find(env(:,2)>0)
tolpos =env(tolpos, 1)
plot(x(tolpos), ytolmax(tolpos),'sk')

Xpos = X ( tolpos, :)
[tolmaxpos,argmaxpos, envpos] = tolsolvty(Xpos,Xpos,infy(tolpos)',supy(tolpos)',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_steam = ir_problem(Xpos, y(tolpos)', epsilon(tolpos)', lb);

for ii=1:length(Xpos)
  ytolmaxpos(ii) = argmax(1) + argmax(2)*Xpos(ii, 2)
end


figure
hold on
pcolor = [0.9 0.7 0.7]
%pcolor = RoyalMail


%pcolor = 2*Pantone
% point forward - back
yp = ir_predict(Xp, irp_steam)
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]

 h2 =  patch(px,py,pcolor);
##   plot(px,py(:,1),"m-","LineWidth",1, "color", 0.5*pcolor);
##   plot(x,yp(:,2),"m-","LineWidth",1, "color", 0.5*pcolor);


errorbar(x, ytolmaxpos, epsilon,"~.r");
%
p3 = plot(x, ytolmaxpos, '.r')

xlimits = [0.001 0.0055];
##ir_plotmodelset(irp_steam, xlimits)
##ir_scatter(irp_steam,'bo')

xp = [0.004 0.0045 0.005]'
xp = [x; xp]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_steam)
ypmid = mean(yp,2)                     # средние значения прогнозных интервалов
yprad = 0.5 * (yp(:,2) - yp(:,1))
ir_scatter(ir_problem(Xp,ypmid,yprad),'k.')
p4 = plot(xp, ypmid, '.k')
plot(xp, ypmid, '--k')
 lgd34 = legend([p3 p4 ], ...
  {'INN data', 'prediction'})
  set(lgd34, 'fontsize', 14);
set(gca, 'fontsize', 14)
xlabel('BT/Ip')
ylabel('Rinv')
grid on


