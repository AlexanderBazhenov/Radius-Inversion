%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2025-06-07
clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-08-14
dirnow = 'e:\Users\Public\Documents\ST\2025\T\'
dirroot ='e:\Users\Public\Documents\ST\2024\T\'
dir2023 ='e:\Users\Public\Documents\ST\2023\T\'
dirki ='e:\Users\Public\Documents\ST\2024\T\kinterval-0.0.1\'
dir2D = 'e:\Users\Public\Documents\ST\2024\T\IntLinInc2D\'
dirRinvOut = 'e:\Users\Public\Documents\ST\2025\T\Rinv\'
dirZhilin = 'e:\Users\Public\Documents\ST\2025\T\octave-interval\m'

% HomePC
##dirnow = 'D:\ST\2025\T\'
##dirroot = 'D:\ST\2024\T\'
##dirki = 'D:\ST\2024\T\kinterval-0.0.1'
##dirData = 'D:\ST\2024\T\DRS4\'
##dir2023 =  'd:\ST\2023\T\'
##dirRinvOut = 'D:\ST\2025\ST\2025\T\Rinv\'
##dirZhilin = 'd:\ST\2025\T\octave-interval\m'
##
##% Toshiba
##dirnow = 'D:\DATA\ST\2025\T\'
##dirroot = 'D:\DATA\\ST\2024\T\'
##dirki = 'D:\DATA\\ST\2024\T\kinterval-0.0.1'
##dirData = 'D:\DATA\\ST\2024\T\DRS4\'
##dir2023 =  'd:\DATA\\ST\2023\T\'
##dirRinvOut = 'D:\DATA\\ST\2025\ST\2025\T\Rinv\'
##dirZhilin = 'd:\DATA\\ST\2025\T\octave-interval\m'

% 2025-03-26
cd(dirnow), pwd

addpath(dirnow)
addpath(dirZhilin)

pkg load interval

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
xlabel('Bt/Ip')
ylabel('Rinv')
grid on
titlestr = strcat('Rinv vs BtIp interval Inn Out')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
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
set(lgd12, 'location', 'east');
titlestr = strcat('Rinv by BtIp interval Inn Out HIST')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
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
%%%%%%%%%%%%%%%%%%%%%%%  ARRAYS OF RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Correct RestOUT
% Theshold reasonable radius
radTHR = 3
CorrectRestOUT
xlim([0.0015 0.004])
%%%%%%%%%%%%%%%%%%%%%%%  /ARRAYS OF RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
titlestr = strcat('Rinv vs BtIp HISTinterval Inn Out',  ' Max datum radius=', num2str(radTHR))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
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
%%%%%%%%%%%%%%%%%%%%%%%%%    OUT  FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
errorbar(x, y, epsilon,"~.b");
plot(x, ytolmax,'sb')
plot(x, ytolmax,'-b')
% TOL_i > 0
tolpos = find(env(:,2)>0)
tolpos =env(tolpos, 1)
plot(x(tolpos), ytolmax(tolpos),'sk')
%
set(gca, 'fontsize', 14)
##px = [ xp; xp(end:-1:1) ]
##py = [ yp(:, 1); yp(end:-1:1, 2) ]
##h2 =  patch(px,py,pcolor);
xlabel('Bt/Ip')
ylabel('Rinv')
%
titlestr = strcat('Rinv OUT vs BpIp intervalHIST', ' radTHR=', num2str(radTHR))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%%  /OUT  FIGURE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
Xpos = X ( tolpos, :)
[tolmaxpos,argmaxpos, envpos] = tolsolvty(Xpos,Xpos,infy(tolpos)',supy(tolpos)',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_steam = ir_problem(Xpos, y(tolpos)', epsilon(tolpos)', lb);

for ii=1:length(Xpos)
  ytolmaxpos(ii) = argmax(1) + argmax(2)*Xpos(ii, 2)
end
%
%%%%%%%%%%%%%%%%%%%%%%%%% PREDICT FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
pcolor = [0.7 0.9 0.7]

%xlimits = [0.0019 0.0056];
% Points to predict
xpfuture = [0.004 0.0045 0.005]'
xp = [x; xpfuture]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_steam)
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]
h2 =  patch(px,py,pcolor);

ypmid = mean(yp,2)                     # средние значения прогнозных интервалов
yprad = 0.5 * (yp(:,2) - yp(:,1))
%
ROIfuture = length(Xp)-length(xpfuture)+1:length(Xp)
Xpfuture = Xp(ROIfuture,:)
ir_scatter(ir_problem(Xpfuture,ypmid(ROIfuture),yprad(ROIfuture)),'r.')

%ir_scatter(ir_problem(Xp,ypmid,yprad),'r.')
p2 = plot(xp(ROIfuture), ypmid(ROIfuture), 'sr')
% OUT data
errorbar(x, ytolmaxpos, epsilon,"~.b");
p1 = plot(x, ytolmaxpos, '.b')
%
%plot(xp, ypmid, '.k')
 lgd12 = legend([p1 p2 ], ...
  {'OUT data', 'prediction'})
  set(lgd12, 'fontsize', 14);
set(gca, 'fontsize', 14)

xlabel('Bt/Ip')
ylabel('Rinv')
%
titlestr = strcat('Rinv OUT vs BpIp intervalHIST w prediction', ' radTHR=', num2str(radTHR))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
% /OUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



