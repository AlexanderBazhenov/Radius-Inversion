%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-05-27
% Nick Mordovin results
DATARint = csvread("interval_inversion.csv")
% read results
ShotInt = DATARint (2:end, 1);
Rinnmid = DATARint (2:end, 2);
Rinnrad = DATARint (2:end, 3);
Routmid = DATARint (2:end, 4);
Routrad = DATARint (2:end, 5);
BtInt = DATARint (2:end, 6);
IpInt = DATARint (2:end, 7);
for ii = 1:length(ShotInt)
  BtIpInt(ii)=  BtInt (ii) / IpInt(ii);
end
%
figure
hold on
errorbar(BtIpInt, Rinnmid, Rinnrad,"~.b");
errorbar(BtIpInt, Routmid, Routrad,"~.r");
p1 = plot(BtIpInt, Rinnmid, 'sb')
p2 = plot(BtIpInt, Routmid, 'sr')
 lgd12 = legend([p1 p2 ], ...
  {'Inn', 'Out'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('BT/Ip')
ylabel('Rinv')
grid on
titlestr = strcat('Rinv vs BpIp interval Inn Out')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%figure
hist(BtIpInt, 40)
%
xxBtIp = [0.0018 0.0022 0.0024 0.0026 0.00275 0.00295 0.0032 0.0034 0.00355 0.00365 0.0039]
for ii = 1 : length (xxBtIp)
  xx = [xxBtIp(ii) xxBtIp(ii)]
  yy = [0 60 ]
  plot(xx, yy, '--k')
end
%
##xx = [0.0018 0.0018]
##yy = [0 60 ]
##plot(xx, yy, '--k')
##xx = [0.0022 0.0022]
##plot(xx, yy, '--k')
##xx = [0.0024 0.0024]
##plot(xx, yy, '--k')
##xx = [0.0026 0.0026]
##plot(xx, yy, '--k')
##xx = [0.00275 0.00275]
##plot(xx, yy, '--k')
##xx = [0.00295 0.00295]
##plot(xx, yy, '--k')
##xx = [0.0032 0.0032]
##plot(xx, yy, '--k')
##xx = [0.0034 0.0034]
##plot(xx, yy, '--k')
##xx = [0.00355 0.00355]
##plot(xx, yy, '--k')
##xx = [0.00365 0.00365]
##plot(xx, yy, '--k')
    set(lgd12, 'location', 'east');
titlestr = strcat('Rinv by BpIp interval Inn Out HIST')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hold on
errorbar(BtIpInt, Routmid, Routrad,"~.k");
for ii = 1 : length (xxBtIp)
  xx = [xxBtIp(ii) xxBtIp(ii)]
  yy = [40 60 ]
  plot(xx, yy, '--k')
end
xlim([0.0015 0.004])
% arrays of results
RestINNarray = []
RestOUTarray = []
%
for ii = 1: length (xxBtIp)-1
[BtIpIntInd] = find(BtIpInt > xxBtIp(ii) & BtIpInt < xxBtIp(ii+1))
if (length(BtIpIntInd) > 0 )
   % IntervalHIST
  RinvGmidOUT = Routmid(BtIpIntInd)
  RinvGradOUT = Routrad(BtIpIntInd)

  X = midrad(RinvGmidOUT, RinvGradOUT)
  % W = ?
  nbins = 8
  ##minC12 = min( inf(X) ), maxC12 = max( sup(X) ), midC12 = ( min( inf(X) )+ max( sup(X) ) )/2,
  ##clear C, C = [  infsup(minC12, midC12), infsup(midC12, maxC12)  ]
  ##C4 = []
  ##C4 = [C4,  infsup(minC12, minC12+ (midC12-minC12)/2) ]
  ##C4 = [C4, infsup( minC12+ (midC12-minC12)/2, midC12) ]
  ##C4 = [C4, infsup( midC12, midC12+ (maxC12 - midC12)/2) ]
  ##C4 = [C4, infsup( midC12+ (maxC12 - midC12)/2,  maxC12) ]
  ##W = C4
  % [CXwid]= XinCrel(X, C4)
  stepW = (max(sup(X)) -min(inf(X)))/ (nbins)
  %Wterm = min(inf(dataIR)) : stepW : max(sup(dataIR))
  for jj=1:nbins
    W(jj) =  infsup(min(inf(X))+stepW*(jj-1), min(inf(X)) + stepW*jj);
   % infsup(min(inf(dataIR))+stepW*ii, min(inf(dataIR)) + stepW*(ii+1)) ]
  end
  %
  tmp = XinCrel(X, W);
  XbyC = sum(tmp, 2);
  %
  sum(XbyC)
  HistXbyC = XbyC/sum(XbyC)
  cumsumHistXbyC = cumsum(HistXbyC)
  % find Quartiles
  Q1less = find(cumsumHistXbyC < .25)
  Q3more = find(cumsumHistXbyC > .75)
  %
  ##RestINN = infsup(inf(W(Q1less+1)), sup(W(Q3more-1)))
  ##RestOUT = infsup(inf(W(1)), sup(W(end)))
  RestINN = infsup(inf(W(Q1less(end)+1)), sup(W(Q3more(1)-1)))
  RestOUT = infsup(inf(W(1)), sup(W(end)))
  RestINNarray = [RestINNarray, RestINN ]
  RestOUTarray = [RestOUTarray, RestOUT ]
  %
  errorbar(mean(BtIpInt(BtIpIntInd)), mid(RestOUT), rad(RestOUT),"~.r");
  errorbar(mean(BtIpInt(BtIpIntInd)), mid(RestINN), rad(RestINN),"~.b");
else
  RestINNarray = [RestINNarray, NaN ]
  RestOUTarray = [RestOUTarray, NaN ]
end
end
xlim([0.0015 0.004])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% xxBtIp = [0.0018 0.0022 0.0024 0.0026 0.00275 0.00295 0.0032 0.0034 0.00355 0.00365 0.0039]
for kk = 1: length(xxBtIp)-1
  meanW(kk) = (xxBtIp(kk) + xxBtIp(kk+1))/2
end
%
figure
hold on
errorbar(meanW, mid(RestINNarray), rad(RestINNarray),"~.b");
errorbar(meanW, mid(RestOUTarray), rad(RestOUTarray),"~.r");
p1 = plot(meanW, mid(RestINNarray), 'sb')
p2 = plot(meanW, mid(RestOUTarray), 'sr')
 lgd12 = legend([p1 p2 ], ...
  {'Inn', 'Out'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Bt/Ip')
ylabel('Rinv')
xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Rinv vs BpIp HISTinterval Inn Out')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

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
pcolor = [0.7 0.9 0.7]
%pcolor = 2*Pantone
% point forward - back
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]
 h1 =  patch(px,py,pcolor);
##   plot(px,py(:,1),"m-","LineWidth",1, "color", 0.5*pcolor);
##   plot(x,yp(:,2),"m-","LineWidth",1, "color", 0.5*pcolor);


errorbar(x, ytolmaxpos, epsilon,"~.r");
%
p1 = plot(x, ytolmaxpos, '.r')

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
p2 = plot(xp, ypmid, '.k')
plot(xp, ypmid, '--k')
 lgd12 = legend([p1 p2 ], ...
  {'data', 'prediction'})
  set(lgd12, 'fontsize', 14);
set(gca, 'fontsize', 14)
ylabel('Bt/Ip')
xlabel('Rinv')
%
titlestr = strcat('Rinv vs BpIp intervalHIST w prediction', ' radTHR=', num2str(radTHR))
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
% /OUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Correct RestOUT
% Theshold reasonable radius
radTHR = 3
RestINNarray = []
RestOUTarray = []
%
for ii = 1: length (xxBtIp)-1
[BtIpIntInd] = find(BtIpInt > xxBtIp(ii) & BtIpInt < xxBtIp(ii+1))
if (length(BtIpIntInd) > 0 )
   % IntervalHIST
  RinvGmidOUT = Routmid(BtIpIntInd)
  RinvGradOUT = Routrad(BtIpIntInd)
%
indradTHR = find (RinvGradOUT < radTHR)
  RinvGmidOUT = RinvGmidOUT(indradTHR )
  RinvGradOUT = RinvGradOUT(indradTHR )

  X = midrad(RinvGmidOUT, RinvGradOUT)
  % W = ?
  nbins = 8
  ##minC12 = min( inf(X) ), maxC12 = max( sup(X) ), midC12 = ( min( inf(X) )+ max( sup(X) ) )/2,
  ##clear C, C = [  infsup(minC12, midC12), infsup(midC12, maxC12)  ]
  ##C4 = []
  ##C4 = [C4,  infsup(minC12, minC12+ (midC12-minC12)/2) ]
  ##C4 = [C4, infsup( minC12+ (midC12-minC12)/2, midC12) ]
  ##C4 = [C4, infsup( midC12, midC12+ (maxC12 - midC12)/2) ]
  ##C4 = [C4, infsup( midC12+ (maxC12 - midC12)/2,  maxC12) ]
  ##W = C4
  % [CXwid]= XinCrel(X, C4)
  stepW = (max(sup(X)) -min(inf(X)))/ (nbins)
  %Wterm = min(inf(dataIR)) : stepW : max(sup(dataIR))
  for jj=1:nbins
    W(jj) =  infsup(min(inf(X))+stepW*(jj-1), min(inf(X)) + stepW*jj);
   % infsup(min(inf(dataIR))+stepW*ii, min(inf(dataIR)) + stepW*(ii+1)) ]
  end
  %
  tmp = XinCrel(X, W);
  XbyC = sum(tmp, 2);
  %
  sum(XbyC)
  HistXbyC = XbyC/sum(XbyC)
  cumsumHistXbyC = cumsum(HistXbyC)
  % find Quartiles
  Q1less = find(cumsumHistXbyC < .25)
  Q3more = find(cumsumHistXbyC > .75)
  %
  ##RestINN = infsup(inf(W(Q1less+1)), sup(W(Q3more-1)))
  ##RestOUT = infsup(inf(W(1)), sup(W(end)))
  RestINN = infsup(inf(W(Q1less(end)+1)), sup(W(Q3more(1)-1)))
  RestOUT = infsup(inf(W(1)), sup(W(end)))
  RestINNarray = [RestINNarray, RestINN ]
  RestOUTarray = [RestOUTarray, RestOUT ]
  %
  errorbar(mean(BtIpInt(BtIpIntInd)), mid(RestOUT), rad(RestOUT),"~.r");
  errorbar(mean(BtIpInt(BtIpIntInd)), mid(RestINN), rad(RestINN),"~.b");
else
  RestINNarray = [RestINNarray, NaN ]
  RestOUTarray = [RestOUTarray, NaN ]
end
end
xlim([0.0015 0.004])

% /Correct RestOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
