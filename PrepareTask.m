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
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /PREPARE TASK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
