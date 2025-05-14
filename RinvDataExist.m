% 2025-05-13
%
RinvDataExist = zeros(length(DATARinv),1);
for shotNinv = 3:length(DATARinv )
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE TASK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% file "inversion radius"
% shotNinv = 14 -> shot 42354 "normalised_export.csv"
% shotNinv = 20 -> shot 42664 "normalised_export.csv"
  ShotROI = ShotRinv(shotNinv);
%
% /file "inversion radius"

ShotROIind =find(Shot == ShotROI);

if length(ShotROIind)>0
  RinvDataExist (shotNinv)= 1;
end

end
sum(RinvDataExist(:))
