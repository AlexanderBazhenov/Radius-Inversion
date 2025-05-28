% 2025-05-28
% linear regression by histogrammed data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUT
x = meanW';        # количество затраченного топлива
y =  mid(RestOUTarray);        # объем произведенного пара
epsilon = rad(RestOUTarray);  # верхняя граница ошибки для y_i
indNaN  = isnan(mid(RestOUTarray))
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
errorbar(x, ytolmaxpos, epsilon,"~.r");
%
p1 = plot(x, ytolmaxpos, '.r')

xlimits = [0.001 0.0055];
##ir_plotmodelset(irp_steam, xlimits)
##ir_scatter(irp_steam,'bo')

xp = [0.0015; 0.004; 0.0045; 0.005]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_steam)
ypmid = mean(yp,2)                     # средние значения прогнозных интервалов
yprad = 0.5 * (yp(:,2) - yp(:,1))
ir_scatter(ir_problem(Xp,ypmid,yprad),'k.')
p2 = plot(xp, ypmid, '.r')
plot(xp, ypmid, '--k')
 lgd12 = legend([p1 p2 ], ...
  {'data', 'prediction'})
  set(lgd12, 'fontsize', 14);
set(gca, 'fontsize', 14)
ylabel('Bt/Ip')
xlabel('Rinv')
titlestr = strcat('Rinv vs BpIp intervalHIST w prediction')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd



