% Test RinvTollCorr.m
% 2025-06-30
% INI
ROI = []
ROI = [1:4 67 75]
ROI = [1:4 67 68 74 75]
ROI = [1:4 50:55 67:75]
ROI = [1:4 50:66 67:75]
ROI = [1:4 40:45 50:75]
ROI = [1:4 40:75]
ROI = [1:4 20:25 40:75]
ROI = [1:4 20:75]
ROI = [1:75]
%
BtIpInt = BtIpIntsorted;
Rinnmid = Rinnmidsorted;
Rinnrad = Rinnradsorted;
Routmid = Routmidsorted;
Routrad = Routradsorted;
%
x0 = BtIpInt(ROI)'
Rinnmid = Rinnmid(ROI)
Rinnrad = Rinnrad(ROI)

figure
hold on
errorbar(x0, Rinnmid, Rinnrad,"~.b");
%errorbar(x0, Routmid, Routrad,"~.r");
p1 = plot(x0, Rinnmid, 'sb')
%p2 = plot(x0, Routmid, 'sr')
% 1st try
X0 = [ x0.^0 x0 ];
[tolmax0,argmax0, env0] = tolsolvty(X0,X0,Rinnmid-Rinnrad,Rinnmid+Rinnrad,1);
%
ytol0 = []
for ii=1:length(X0)
  ytol0(ii) = argmax0(1) + argmax0(2)*X0(ii, 2);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEG-POS cliques
eqnumber0 = env0(:,1)
eqtol0 = env0(:,2)
[eqnumber0sort, indeqnumber0sort] = sort(eqnumber0)
eqtol0sort = eqtol0(indeqnumber0sort)
tolneg0 = find(eqtol0sort < 0)
tolpos0 = find(eqtol0sort >= 0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Xpos = X0 ( tolpos0, :)
y =  Rinnmid(tolpos0)
epsilon = Rinnrad(tolpos0)


lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_Rinv = ir_problem(Xpos, y, epsilon, lb);
%
[tolmaxpos0,argmaxpos0, envpos0] = tolsolvty(Xpos,Xpos,y-epsilon,y+epsilon,1);
ytolmaxpos = []
for ii=1:length(Xpos)
  ytolmaxpos(ii) = argmaxpos0(1) + argmaxpos0(2)*Xpos(ii, 2)
end
%
figure
hold on
% Plot Pos Neg Data
PlotPosNeg
%
titlestr = strcat('Rinv INN vs BtIp All Pos ROI count=', num2str(length(ROI)))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

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
% Plot Pos Neg Data
PlotPosNeg
%
titlestr = strcat('Rinv INN vs BtIp All Pos ROI count=', num2str(length(ROI)), ' Forecast')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
