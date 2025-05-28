%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-05-14
% RinvArray vs BtIparray
figure
hist(Rinvarray, 20)
%
BtIparray = zeros(length(DATARinv),1);
%
for shotNinv = 3:length(DATARinv )
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE TASK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% file "inversion radius"
if   RinvDataExist (shotNinv) == 1;
   ShotROI = ShotRinv(shotNinv);
%
  Time1 = Time1Rinv(shotNinv);
  Time2 = Time2Rinv(shotNinv);
% /file "inversion radius"

% file "normalised_export"
ShotROIind =find(Shot == ShotROI);
TimeROI1 =find(abs(time - Time1) < timeerr);
ShotTimeROIind1  = intersect(ShotROIind, TimeROI1);
TimeROI2 =find(abs(time - Time2) < timeerr);
ShotTimeROIind2  = intersect(ShotROIind, TimeROI2);
% /file "normalised_export"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /PREPARE TASK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  BtIparray(shotNinv) = BtIp(ShotTimeROIind1(1));
end
end
% PLOT BtIparray
##figure
##plot(BtIparray(RinvDataExist>0), 'sk')
##% NZero - Non Zero data
##[BtIparraysort, BtIpsortInd ] = sort(BtIparray)
##[ BtIparraysortNZero, BtIpsortIndNZero ] = find( BtIparraysort>0)
##% PLOT points
##figure
##plot(BtIparraysort(BtIparraysortNZero), Rinvarray(BtIparraysortNZero), 'sk')
##% Error model
##errRint = 1
##Rinvarrayint = midrad(Rinvarray(BtIparraysortNZero), errRint*ones(length(BtIparraysortNZero),1))
##% PLOT data scattering interval
##figure
##errorbar (BtIparraysort(BtIparraysortNZero)   , Rinvarray(BtIparraysortNZero), errRint*ones(length(BtIparraysortNZero),1),"~.b");
% /RinvArray vs BtIparray
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NonZero data
[ BtIparrayNZero, BtIpIndNZero ] = find( BtIparray>0);
BtIparrayNZ = BtIparray(BtIparrayNZero);
RinvarrayNZ = Rinvarray(BtIparrayNZero);

figure
plot(BtIparrayNZ, RinvarrayNZ, 'sk')
% not NaN data
RinvarrayNZNaN = isnan(RinvarrayNZ);
RinvarrayNZtrue = find(RinvarrayNZNaN == 0)

ShotROIstr = num2str(ShotROI)
T1str = num2str(Time1)
T2str = num2str(Time2)
figure
errorbar(BtIparrayNZ(RinvarrayNZtrue), RinvarrayNZ(RinvarrayNZtrue), errRint*ones(length(RinvarrayNZtrue),1),"~.b");
set(gca, 'fontsize', 14)
ylabel('BT/Ip')
xlabel('Rinv')
titlestr = strcat('Rinv vs BpIp interval')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-05-23
x = BtIparrayNZ(RinvarrayNZtrue);        # количество затраченного топлива
y = RinvarrayNZ(RinvarrayNZtrue);        # объем произведенного пара
epsilon = errRint*ones(length(RinvarrayNZtrue),1);  # верхняя граница ошибки для y_i
infy = y - epsilon
supy = y + epsilon

X = [ x.^0 x ];                               # матрица значений переменных при beta1 и beta2
%
[tolmax,argmax, env] = tolsolvty(X,X,infy,supy,1);
for ii=1:length(X)
  ytolmax(ii) = argmax(1) + argmax(2)*X(ii, 2)
end
figure
hold on
errorbar(BtIparrayNZ(RinvarrayNZtrue), RinvarrayNZ(RinvarrayNZtrue), errRint*ones(length(RinvarrayNZtrue),1),"~.b");
plot(x, ytolmax,'sr')
plot(x, ytolmax,'-r')

% tol_i > 0
tolpos = find(env(:,2)>0)
tolpos =env(tolpos, 1)
plot(x(tolpos), ytolmax(tolpos),'sk')

Xpos = X ( tolpos, :)
[tolmaxpos,argmaxpos, envpos] = tolsolvty(Xpos,Xpos,infy(tolpos),supy(tolpos),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_steam = ir_problem(Xpos, y(tolpos), epsilon(tolpos), lb);

for ii=1:length(Xpos)
  ytolmaxpos(ii) = argmax(1) + argmax(2)*Xpos(ii, 2)
end


figure
hold on
errorbar(BtIparrayNZ(RinvarrayNZtrue), RinvarrayNZ(RinvarrayNZtrue), errRint*ones(length(RinvarrayNZtrue),1),"~.b");
%
p1 = plot(BtIparrayNZ(RinvarrayNZtrue), RinvarrayNZ(RinvarrayNZtrue), '.b')

##xlimits = [0.0015 0.0045];
##ir_plotmodelset(irp_steam, xlimits)
##ir_scatter(irp_steam,'bo')

xp = [0.0015; 0.004; 0.0045]
Xp = [xp.^0 xp];
yp = ir_predict(Xp, irp_steam)
ypmid = mean(yp,2)                     # средние значения прогнозных интервалов
yprad = 0.5 * (yp(:,2) - yp(:,1))
ir_scatter(ir_problem(Xp,ypmid,yprad),'r.')
p2 = plot(xp, ypmid, '.r')
plot(xp, ypmid, '--k')
 lgd12 = legend([p1 p2 ], ...
  {'data', 'prediction'})
  set(lgd12, 'fontsize', 14);
set(gca, 'fontsize', 14)
ylabel('BT/Ip')
xlabel('Rinv')
titlestr = strcat('Rinv vs BpIp interval w predicition')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd



