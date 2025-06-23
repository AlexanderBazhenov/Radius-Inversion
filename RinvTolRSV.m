%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2025-06-23
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
##figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd

