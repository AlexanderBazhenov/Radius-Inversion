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
dirnow = 'D:\ST\2025\T\'
dirroot = 'D:\ST\2024\T\'
dirki = 'D:\ST\2024\T\kinterval-0.0.1'
dirData = 'D:\ST\2024\T\DRS4\'
dir2023 =  'd:\ST\2023\T\'
dirRinvOut = 'D:\ST\2025\ST\2025\T\Rinv\'
dirZhilin = 'd:\ST\2025\T\octave-interval\m'
##
% Toshiba
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATA INI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-05-27
% Nick Mordovin results
##DATARint = csvread("interval_inversion.csv")
##% read results
##ShotInt = DATARint (2:end, 1);
##Rinnmid = DATARint (2:end, 2);
##Rinnrad = DATARint (2:end, 3);
##Routmid = DATARint (2:end, 4);
##Routrad = DATARint (2:end, 5);
##BtInt = DATARint (2:end, 6);
##IpInt = DATARint (2:end, 7);
##for ii = 1:length(ShotInt)
##  BtIpInt(ii)=  BtInt (ii) / IpInt(ii);
##end
%
%save DATARintINI Rinnmid Rinnrad Routmid Routrad BtIpInt
%load DATARintINI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /DATA INI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

##[BtIpIntsorted, indBtIp] = sort(BtIpInt)
##Rinnmidsorted = Rinnmid( indBtIp)
##Rinnradsorted = Rinnrad( indBtIp)
##Routmidsorted = Routmid( indBtIp)
##Routradsorted = Routrad( indBtIp)
%save DATARintINIsorted Rinnmidsorted Rinnradsorted Routmidsorted Routradsorted BtIpIntsorted

%%%%%%%%%%%%%%%%%%%%%%%% SORTED by BtIpInt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load DATARintINIsorted
%
##figure
##hold on
####plot(BtIpIntsorted, Rinnmidsorted)
####plot(BtIpIntsorted, Routmidsorted)
##errorbar(BtIpIntsorted, Rinnmidsorted, Rinnradsorted,"~.b");
##errorbar(BtIpIntsorted, Routmidsorted, Routradsorted,"~.r");
##%
BtIpInt = BtIpIntsorted
Rinnmid = Rinnmidsorted
Rinnrad = Rinnradsorted
Routmid = Routmidsorted
Routrad = Routradsorted
%%%%%%%%%%%%%%%%%%%%%%%% /SORTED by BtIpInt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
##figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd

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
##figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

##figure
##hold on
##errorbar(BtIpInt, Routmid, Routrad,"~.k");
##for ii = 1 : length (xxBtIp)
##  xx = [xxBtIp(ii) xxBtIp(ii)]
##  yy = [40 60 ]
##  plot(xx, yy, '--k')
##end
##xlim([0.0015 0.004])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    OPTIMAL INN RAD     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CorriditINNxyCorr


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%      INTERVAL HIST     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
InteHIST

