% 2025-06-23
%%%%%%%%%%%%%%%%%%%%%%%%%%%   INN CORR      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% argmax
##x0 = BtIpInt'
##X0 = [ x0.^0 x0 ];
##[tolmax0,argmax0, env0] = tolsolvty(X0,X0,Rinnmid-Rinnrad,Rinnmid+Rinnrad,1);
%
##for ii=1:length(X0)
##  ytol0(ii) = argmax0(1) + argmax0(2)*X0(ii, 2);
##end
##%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CorriditINNxyCorr.m
##tolneg0 = find(env0(:,2)<0)
##tolpos0 = find(env0(:,2)>=0)
##eqnumber0 = env0(:,1)
##eqtol0 = env0(:,2)
[eqnumber0sort, indeqnumber0sort] = sort(eqnumber0)
eqtol0sort = eqtol0(indeqnumber0sort)
tolneg0 = find(eqtol0sort < 0)
tolpos0 = find(eqtol0sort >= 0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = [ x0.^0 x0 ];
Xpos = X ( tolpos0, :)
y =  Rinnmid(tolpos0)
epsilon = Rinnrad(tolpos0)

lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_Rinv = ir_problem(Xpos, y, epsilon, lb);
%
[tolmaxpos0,argmaxpos0, envpos0] = tolsolvty(Xpos,Xpos,y-epsilon,y+epsilon,1);
for ii=1:length(Xpos)
  ytolmaxpos(ii) = argmaxpos0(1) + argmaxpos0(2)*Xpos(ii, 2)
end
%
figure
hold on
%p1 = plot(eqnumber0, eqtol0,'sk')
p1 = plot(x0(tolpos0),  Rinnmid(tolpos0),'sk')
%p2 = plot(x0(tolneg0), Rinnmid(tolneg0),'sr')
errorbar(x0(tolpos0),  Rinnmid(tolpos0),  Rinnrad(tolpos0),"~.b")
%errorbar(x0(tolneg0), Rinnmid(tolneg0), Rinnrad(tolneg0), "~.r")
p3 = plot(x0(tolpos0), ytolmaxpos, '--k')
 lgd13 = legend([p1  p3], ...
  {'Pos',  'argmaxpos'})
  set(lgd13, 'fontsize', 14);
 %   set(lgd12, 'location', 'northwest');
set(gca, 'fontsize', 14)
ylabel('Rinv')
xlabel('BtIp')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Rinv INN vs BtIp Pos')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
## figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
%p1 = plot(eqnumber0, eqtol0,'sk')
p1 = plot(x0(tolpos0),  Rinnmid(tolpos0),'sk')
p2 = plot(x0(tolneg0), Rinnmid(tolneg0),'sr')
errorbar(x0(tolpos0),  Rinnmid(tolpos0),  Rinnrad(tolpos0),"~.b")
errorbar(x0(tolneg0), Rinnmid(tolneg0), Rinnrad(tolneg0), "~.r")
p3 = plot(x0(tolpos0), ytolmaxpos, '--k')
 lgd123 = legend([p1 p2 p3], ...
  {'Pos', 'Neg', 'argmaxpos'})
  set(lgd123, 'fontsize', 14);
 %   set(lgd12, 'location', 'northwest');
set(gca, 'fontsize', 14)
ylabel('Rinv')
xlabel('BtIp')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Rinv INN vs BtIp')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
## figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd



%xlimits = [0.0019 0.0056];
% Points to predict
xpfuture = [0.004 0.0045 0.005]'
% 2025-06-29
xpfuture = []
xp = [x0; xpfuture]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_Rinv)
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]

figure
hold on
pcolor = [0.7 0.9 0.7]
h2 =  patch(px,py,pcolor);
  xlim([0.0018 0.0039])
%
errorbar(x0(tolpos0),  Rinnmid(tolpos0),  Rinnrad(tolpos0),"~.b")
%errorbar(x0(tolneg0), Rinnmid(tolneg0), Rinnrad(tolneg0), "~.r")
p1 = plot(x0(tolpos0),  Rinnmid(tolpos0),'sk')
%p2 = plot(x0(tolneg0), Rinnmid(tolneg0),'sr')
## lgd12 = legend([p1 p2 p3], ...
##  {'Pos', 'Neg', 'argmax'})
##  set(lgd123, 'fontsize', 14);
%
set(gca, 'fontsize', 14)
ylabel('Rinv')
xlabel('BtIp')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Rinv INN vs BtIp Pos Predict')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
## figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd


##figure
##hold on
##pcolor = [0.7 0.9 0.7]
##%xlimits = [0.0019 0.0056];
##% Points to predict
##xpfuture = [0.004 0.0045 0.005]'
##xp = [x0(tolpos0); xpfuture]
##Xp = [xp.^0 xp];
##%ir_plotmodelset(irp_steam, xlimits)
##yp = ir_predict(Xp, irp_Rinv)
##px = [ xp; xp(end:-1:1) ]
##py = [ yp(:, 1); yp(end:-1:1, 2) ]
##h2 =  patch(px,py,pcolor);
##  xlim([0.0018 0.0039])
clear  Yp, ypmid, yprad, yint
% Forecast
for ii = 1:length(tolpos0)
  Yp(ii) = infsup(yp(ii,1), yp(ii,2));
end
% Model Interval all data
for ii = 1:length(x0)
  ypmid(ii) = (yp(ii,1) + yp(ii,2))/2;
  yprad(ii) = (-yp(ii,1) + yp(ii,2))/2;
end
% Data Interval @ tolpos0
yint = infsup(Rinnmid(tolpos0)-Rinnrad(tolpos0), Rinnmid(tolpos0)+Rinnrad(tolpos0))

figure
hold on
errorbar(x0(tolpos0),  ypmid(tolpos0),  yprad(tolpos0),"~.b")
errorbar(x0(tolpos0),  Rinnmid(tolpos0),  Rinnrad(tolpos0),"~.r")

##for ii = 1:length(tolpos0)
##   [outinf, outsup]  = wedge(yint(ii), Yp(ii) );
##   widwedge(ii) = outsup - outinf;
##end
##figure
##plot(x0(tolpos0), widwedge, 'sk')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   BOUNDARY CHECK     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epstol = 0.02
BoundaryCheck
##for ii = 1:length(tolpos0)
##   dif1 = abs(inf(yint(ii))-inf(Yp(ii)));
##   dif2 = abs(sup(yint(ii))-sup(Yp(ii)));
##   dif3 = abs(inf(yint(ii))-sup(Yp(ii)));
##   dif4 = abs(sup(yint(ii))-inf(Yp(ii)));
##   Dif = [dif1, dif2, dif3, dif4];
##   DifY(ii) = min(Dif);
##end
##[DifYzero, DifYzeroInd] = find(DifY< 0.0001)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hold on
pcolor = [0.7 0.9 0.7]
%xlimits = [0.0019 0.0056];
% Points to predict
xpfuture = [0.004 0.0045 0.005]'
xp = [x0; xpfuture]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_Rinv)
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]
h2 =  patch(px,py,pcolor);
  xlim([0.0018 0.0039])
%
errorbar(x0(tolpos0),  Rinnmid(tolpos0),  Rinnrad(tolpos0),"~.k")
%errorbar(x0(tolneg0), Rinnmid(tolneg0), Rinnrad(tolneg0), "~.r")
p1 = plot(x0(tolpos0),  Rinnmid(tolpos0),'.k')
%p2 = plot(x0(tolneg0), Rinnmid(tolneg0),'sr')
## lgd12 = legend([p1 p2 p3], ...
##  {'Pos', 'Neg', 'argmax'})
##  set(lgd123, 'fontsize', 14);
%
errorbar(x0(tolpos0(DifYzeroInd)), Rinnmid(tolpos0(DifYzeroInd)), Rinnrad(tolpos0(DifYzeroInd)), "~.r")
p2 = plot(x0(tolpos0(DifYzeroInd)), Rinnmid(tolpos0(DifYzeroInd)),'sr')
%
 lgd12 = legend([p1 p2 ], ...
  {'Pos', 'Bouddary'})
  set(lgd12, 'fontsize', 14);
%
grid on
set(gca, 'fontsize', 14)
ylabel('Rinv')
xlabel('BtIp')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Rinv INN vs BtIp Pos Predict Boundary')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
 figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%   /BOUNDARY CHECK     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%    RESIDUALS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on

dataind = 1:length(x0);
p0 = plot(xp(dataind),  Rinnmid(dataind)-ypmid(dataind)','.k')
p1 = plot(xp(tolpos0),  Rinnmid(tolpos0)-ypmid(tolpos0)','sb')
%p2 = plot(x0(tolneg0), Rinnmid(tolneg0),'sr')
## lgd12 = legend([p1 p2 p3], ...
##  {'Pos', 'Neg', 'argmax'})
##  set(lgd123, 'fontsize', 14);
%
errorbar(xp(dataind),  Rinnmid(dataind)-ypmid(dataind)', Rinnrad(dataind), "~.k")
p2 = plot(x0(tolpos0(DifYzeroInd)), Rinnmid(tolpos0(DifYzeroInd))-ypmid(tolpos0(DifYzeroInd))','sr')

% Mode
RinnResiduals = midrad(Rinnmid(dataind)-ypmid(dataind)', Rinnrad(dataind))
 [mode, mu_array, max_mu, mode_ind, c_array, C, multi]= modeIR4(RinnResiduals)

Colors_special
figure
hold on
retval = ModePlot (mode, mu_array, max_mu, mode_ind, c_array, C, multi)
titlestr = strcat('Interval mode', ' Residials INN')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%
for ii = 1:length(dataind)
  Res (ii)= (Rinnmid(ii)-ypmid(ii)')/ Rinnrad(ii);
  Lev (ii) = 0.5*(-yp(ii,1) + yp(ii,2))/ Rinnrad(ii);
end
figure
hold on
plot(Lev, Res, '.k')
grid on
set(gca, 'fontsize', 14)
xlabel('leverage')
ylabel('res')
titlestr = strcat(' res-leverage diagram', ' Residials INN')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%     INN EXTENSION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
widadd = min(env0(tolpos0,2))
envp = env0(tolpos0,2)
step = 1
widadd = 0%envp(step)

[eqnumber0sort, indeqnumber0sort] = sort(eqnumber0)
eqtol0sort = eqtol0(indeqnumber0sort)
tolneg0 = find(eqtol0sort < 0)
tolpos0 = find(eqtol0sort >= 0)

infR0 =    Rinnmid-Rinnrad;
supR0 =    Rinnmid+Rinnrad;
infR = infR0;
supR = supR0;
for ii=1:length(infR)
  tolii = eqtol0sort(ii);
  if tolii < 0
    infR(ii) =  infR0(ii) + tolii - widadd;
    supR(ii) =  supR0(ii) - tolii + widadd ;
  end
end
%
figure
hold on
plot(infR, '-b')
plot(supR, '-r')
plot(infR0, '--b')
plot(supR0, '--r')
%
[tolmax0C,argmax0C, env0C] = tolsolvty(X0,X0,infR,supR,1);
%
for ii=1:length(X0)
  ytol0C(ii) = argmax0C(1) + argmax0C(2)*X0(ii, 2);
end
%

%
figure
hold on
errorbar(BtIpInt, Rinnmid, Rinnmid-infR,"~.b");
p1 = plot(BtIpInt, Rinnmid, 'sb')
p2 = plot(BtIpInt, ytol0C, 'sr')
plot(BtIpInt, ytol0C, '-r')

pcolor = [0.7 0.9 0.7]
lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_steam = ir_problem(X0, Rinnmid, Rinnmid-infR, lb);
%xlimits = [0.0019 0.0056];
% Points to predict
xpfuture = [0.004 0.0045 0.005]'
x = x0;
xp = [x; xpfuture]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_steam)
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]
h2 =  patch(px,py,pcolor);

 lgd12 = legend([p1 p2 ], ...
  {'Data INN', 'argmaxtol'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Bt/Ip')
ylabel('Rinv')
grid on
titlestr = strcat('Rinv vs BtIp interval Inn argmax Tolcorr', ' addPosNoStep=', num2str(step))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%%%%   /INN CORR    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure
hold on

pcolor = [0.7 0.9 0.7]
lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_steam = ir_problem(X0, Rinnmid, Rinnmid-infR, lb);
%xlimits = [0.0019 0.0056];
% Points to predict
xpfuture = [0.004 0.0045 0.005]'
x = x0;
xp = [x; xpfuture]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_steam)
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]
h2 =  patch(px,py,pcolor);


errorbar(BtIpInt(tolpos0), Rinnmid(tolpos0), Rinnmid(tolpos0)-infR(tolpos0),"~.k");
errorbar(BtIpInt(tolneg0), Rinnmid(tolneg0), Rinnmid(tolneg0)-infR(tolneg0),"~.b");
p1p = plot(BtIpInt(tolpos0), Rinnmid(tolpos0) , 'sk')
pn1 = plot(BtIpInt(tolneg0), Rinnmid(tolneg0) , 'or')
p2 = plot(BtIpInt, ytol0C, 'sr')
plot(BtIpInt, ytol0C, '-r')


