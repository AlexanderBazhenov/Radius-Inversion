% 2025-05-15
% 3 points for ROI
% R less more
[R1maxT2less, R1maxT2lessInd] = max(R1sort(T2less))
[R1minT2more, R1maxT2moreInd] = min(R1sort(T2more))
[R2maxT2less, R2maxT2lessInd] = max(R2sort(T2less))
[R2minT2more, R2maxT2moreInd] = min(R2sort(T2more))
% T(R)  less more
% less
Rind1less =find(R(ShotTimeROIind1) == R1maxT2less)
midT1(Rind1less)
Rind2less =find(R(ShotTimeROIind2) == R2maxT2less)
midT2(Rind2less)
% more
Rind1more =find(R(ShotTimeROIind1) == R1minT2more)
midT1(Rind1more)
Rind2more =find(R(ShotTimeROIind2) == R2minT2more)
midT2(Rind2more)
% maxJi
Rind1Jimax =find(R(ShotTimeROIind1) == R1sort(maxJi) )
midT1(Rind1Jimax)
Rind2Jimax =find(R(ShotTimeROIind2) == R2sort(maxJi) )
midT2(Rind2Jimax)
