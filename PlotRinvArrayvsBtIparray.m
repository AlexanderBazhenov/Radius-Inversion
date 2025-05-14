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
figure
plot(BtIparray(RinvDataExist>0), 'sk')
% NZero - Non Zero data
[BtIparraysort, BtIpsortInd ] = sort(BtIparray)
[ BtIparraysortNZero, BtIpsortIndNZero ] = find( BtIparraysort>0)
% PLOT points
figure
plot(BtIparraysort(BtIparraysortNZero), Rinvarray(BtIparraysortNZero), 'sk')
% Error model
errRint = 1
Rinvarrayint = midrad(Rinvarray(BtIparraysortNZero), errRint*ones(length(BtIparraysortNZero),1))
% PLOT data scattering interval
figure
errorbar (BtIparraysort(BtIparraysortNZero), Rinvarray(BtIparraysortNZero), errRint*ones(length(BtIparraysortNZero),1),"~.b");
% /RinvArray vs BtIparray
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

