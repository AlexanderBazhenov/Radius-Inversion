% % 2025-04-25
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

% HomePC
dirnow = 'D:\ST\2025\T\'
dirroot = 'D:\ST\2024\T\'
dirki = 'D:\ST\2024\T\kinterval-0.0.1'
dirData = 'D:\ST\2024\T\DRS4\'
dir2023 =  'd:\ST\2023\T\'
dirRinvOut = 'D:\ST\2025\ST\2025\T\Rinv\'

% 2025-03-26
cd(dirnow), pwd

addpath(dirnow)

% 2025-05-11
load RinvData

% 2025-04-28
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TSdataInversionRadius
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%     Time marks before-after sawtooth  %%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
plot(Time1Rinv)
plot(Time2Rinv)
ylim([min(Time1Rinv(3:end))*0.95 1.05*max(Time2Rinv(3:end)) ])
xlim([0 length(DATARinv)]);
set(gca, 'fontsize', 14);
xlabel('Shot count, inversion radius file');
ylabel('Time, ms');
titlestr = strcat('Time before-after sawtooth');
title(titlestr);
##figure_name_out=strcat(titlestr, '.png');
##print('-dpng', '-r300', figure_name_out), pwd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Time max difference
timeerr = 0.1*10
pkg load interval

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  TEST 43043   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Test43043
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  /TEST 43043   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 2025-05-11
RinvArray
% RinvArray -> FindRinvInterval -> PlotRinvOutInn

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


##%%%%%%%%%%%%%%%%%%%%     RESEARCH   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-04-28

ShotROI = 43048
Time1 = 221.81
Time2 = 224.84
FindRinvROIs
PlotRinv

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd(dirRinvOut), pwd
for shotN = 3:length(DATARinv )
  ShotROI = ShotRinv(shotN);
  Time1 = Time1Rinv(shotN);
  Time2 = Time2Rinv(shotN);
  FindRinvROIs
    PlotRinv;
end
cd(dirnow), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-05-06
cd(dirnow)

##
##
##%[out, x1cap, x2cap, x1cup, x2cup] = jaccardKR(x1, x2)
##R1 = R(ShotTimeROIind1)
##R2 = R(ShotTimeROIind2)
##[R12, I1, I2] = intersect(R1, R2)
##%
##x1 = Te(ShotTimeROIind1(I1))
##x2 = Te(ShotTimeROIind2(I2))
##for jj = 1:length(I1)
##  [x1cap, x2cap]=wedge(Tint1(I1(jj)), Tint2(I2(jj)));
##  [x1cup, x2cup]=vee(Tint1(I1(jj)), Tint2(I2(jj)));
##  out=(x2cap-x1cap)/abs(x1cup-x2cup);
##  JiT1T2(jj) = out;
##end
##% find max in the middle
##[maxJiT1T2, maxJiT1T2] = max(JiT1T2(2:end-1))
##maxJi = maxJiT1T2 + 1
##
##I1(maxJi)
##I2(maxJi)
##Rinvnow = R(ShotTimeROIind1(I1(maxJi)))
##Rinvnow = R(ShotTimeROIind2(I2(maxJi)))
##
##%
##ShotROIind =find(Shot == ShotROI);
##
##TimeROI1 =find(abs(time - Time1) < timeerr);
##ShotTimeROIind1  = intersect(ShotROIind, TimeROI1);
##TimeROI2 =find(abs(time - Time2) < timeerr);
##ShotTimeROIind2  = intersect(ShotROIind, TimeROI2);
##
##midT1 = Te(ShotTimeROIind1);
##radT1 = 0.05*midT1;
##Tint1 = midrad(midT1, radT1);
##midT2 = Te(ShotTimeROIind2);
##radT2 = 0.05*midT2;
##Tint2 = midrad(midT2, radT2);


##Rinvarray = NaN(length(DATARinv),1)
##for shotN = 14%length(DATARinv )
##%
##  ShotROI = ShotRinv(shotN);
##%
##ShotROIind =find(Shot == ShotROI);
##TimeROI1 =find(abs(time - Time1) < timeerr);
##ShotTimeROIind1  = intersect(ShotROIind, TimeROI1);
##TimeROI2 =find(abs(time - Time2) < timeerr);
##ShotTimeROIind2  = intersect(ShotROIind, TimeROI2);
##%
##  Time1 = Time1Rinv(shotN);
##  Time2 = Time2Rinv(shotN);
##% jaccardT1T2;
##R1 = R(ShotTimeROIind1)
##R2 = R(ShotTimeROIind2)
##[R12, I1, I2] = intersect(R1, R2)
##%
##x1 = Te(ShotTimeROIind1(I1))
##x2 = Te(ShotTimeROIind2(I2))
##for jj = 1:length(I1)
##  [x1cap, x2cap]=wedge(Tint1(I1(jj)), Tint2(I2(jj)));
##  [x1cup, x2cup]=vee(Tint1(I1(jj)), Tint2(I2(jj)));
##  out=(x2cap-x1cap)/abs(x1cup-x2cup);
##  JiT1T2(jj) = out;
##end
##% find max in the middle
##[maxJiT1T2, maxJiT1T2] = max(JiT1T2(2:end-1))
##maxJi = maxJiT1T2 + 1
##
##I1(maxJi)
##I2(maxJi)
##Rinvnow = R(ShotTimeROIind1(I1(maxJi)))
##%
##Rinvarray (shotN)= Rinvnow;
##end
##
##% / 2025-05-06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-05-05

% 2025-04-30
Bt = DATA (:, 7);
Ip = DATA (:, 6);
for ii = 1:length(DATA)
  BtIp(ii)=  Bt (ii) / Ip(ii);
end

figure
hist(BtIp, 20)
xlim([0.0015 0.009])
set(gca, 'fontsize', 14)
ylabel('Count')
xlabel('Bt div Ip')
  titlestr = strcat('HIST Bt div Ip')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

figure
plot(BtIp)
xlim([0 length(DATA)])
ylim([min(BtIp)*0.9 max(BtIp)*1.1])
set(gca, 'fontsize', 14)
xlabel('Count')
ylabel('Bt div Ip')
  titlestr = strcat('Bt div Ip')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-05-11
% save RinvData DATA DATARinv

figure
plot(BtIp', RinvPoint)

