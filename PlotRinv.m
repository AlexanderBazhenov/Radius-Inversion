% 2025-04-28

% find ROIs
% FindRinvROIs
##ShotROIind =find(Shot == ShotROI);
##%
##TimeROI1 =find(abs(time - Time1) < timeerr);
##ShotTimeROIind1  = intersect(ShotROIind, TimeROI1);
##TimeROI2 =find(abs(time - Time2) < timeerr);
##ShotTimeROIind2  = intersect(ShotROIind, TimeROI2);

% For figure names
ShotROIstr = num2str(ShotROI)
T1str = strcat(num2str(Time1))
T2str = strcat(num2str(Time2))




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POINT-LINE PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PlotTSprofilesPointLines
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /POINT-LINE PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PlotTSprofilesIntervals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /INTERLVAL PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT w LINEs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PlotTSprofilesIntervalBands
%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT w LINEs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

