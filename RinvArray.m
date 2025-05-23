% 2025-05-05
% Radius of inversion interval

%
RinvDataExist
%  2025-05-06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rinvarray = NaN(length(DATARinv),1);
for jj= 1:length(DATARinv)
RinvOUTarray(jj) = infsup(0,0);
RinvINNarray(jj) = infsup(0,0);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for shotNinv = 15 : length(DATARinv )
  if RinvDataExist( shotNinv) == 1
##  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE TASK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PrepareTask
% Do intervals
midT1 = Te(ShotTimeROIind1);
radT1 = 0.05*midT1;
Tint1 = midrad(midT1, radT1);
midT2 = Te(ShotTimeROIind2);
radT2 = 0.05*midT2;
Tint2 = midrad(midT2, radT2);


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
