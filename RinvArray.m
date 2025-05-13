% 2025-05-05
% Radius of inversion interval

%
RinvDataExist
%  2025-05-06
Rinvarray = NaN(length(DATARinv),1)
for jj= 1:length(DATARinv)
RinvOUTarray(jj) = infsup(0,0);
RinvINNarray(jj) = infsup(0,0);
end

for shotNinv = 26:length(DATARinv )
  if RinvDataExist( shotNinv) == 1
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE TASK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% file "inversion radius"
% shotNinv = 14 -> shot 42354 "normalised_export.csv"
% shotNinv = 20 -> shot 42664 "normalised_export.csv"
  ShotROI = ShotRinv(shotNinv);
%
  Time1 = Time1Rinv(shotNinv);
  Time2 = Time2Rinv(shotNinv);
 %
ShotROIstr = num2str(ShotROI)
T1str = strcat(num2str(Time1))
T2str = strcat(num2str(Time2))
% /file "inversion radius"

ShotROIind =find(Shot == ShotROI);

TimeROI1 =find(abs(time - Time1) < timeerr);
ShotTimeROIind1  = intersect(ShotROIind, TimeROI1);
TimeROI2 =find(abs(time - Time2) < timeerr);
ShotTimeROIind2  = intersect(ShotROIind, TimeROI2);

midT1 = Te(ShotTimeROIind1);
radT1 = 0.05*midT1;
Tint1 = midrad(midT1, radT1);
midT2 = Te(ShotTimeROIind2);
radT2 = 0.05*midT2;
Tint2 = midrad(midT2, radT2);


##
##% array of radiuses
##R1 = R(ShotTimeROIind1)
##R2 = R(ShotTimeROIind2)
##% common points in R1 R2
##% 8 points
##[R12, I1, I2] = intersect(R1, R2)
##% I1, I2 indexes in R1 R2
##% Te by I1, I2
##x1 = Te(ShotTimeROIind1(I1))
##x2 = Te(ShotTimeROIind2(I2))
##%%%%%%%%%%%%%%%%%%%%%%%%%%% find Jaccard index Te1, Te2 %%%%%%%%%%%%%%%%%%%%%%%
##for jj = 1:length(I1)
##% jaccard Te1 Te2
##  [x1cap, x2cap]=wedge(Tint1(I1(jj)), Tint2(I2(jj)));
##  [x1cup, x2cup]=vee(Tint1(I1(jj)), Tint2(I2(jj)));
##  out=(x2cap-x1cap)/abs(x1cup-x2cup);
##  JiT1T2(jj) = out;
##end
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT Jaccard index Te1, Te2
##figure
##hold on
##plot(JiT1T2, 'ok')
##% find max Ji in the middle of arrays
##[maxJiT1T2, maxJiT1T2ind] = max(JiT1T2(2:end-1))
##% maxJiT1T2ind - index in R12 cropped
##% maxJi - index in R12
##maxJi = maxJiT1T2ind + 1
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  R(ShotTimeROIind1(I1(maxJi))) =  R(ShotTimeROIind2(I2(maxJi)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2025-05-11
FindRinvInterval;
% JiT1T2over -> RinvOutInn

% results now
Rinvnow = RinvR
RinvINNnow =  RinvINN;
RinvOUTnow = RinvOUT;
%
Rinvarray (shotNinv)= Rinvnow;
RinvINNarray (shotNinv)= RinvINNnow;
RinvOUTarray (shotNinv)= RinvOUTnow;
end
end

% / 2025-05-06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
