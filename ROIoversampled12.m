% 2025-05-16
% ROI oversampled1
stepR = 0.1
Rover1 =  R1(Rind1less):stepR:R1sort(maxJi)
Rtotover1 = R1sort(maxJi) - R1(Rind1less)
dRover1 = stepR / Rtotover1
NstepR1 = round(Rtotover1 / stepR)
T1over1 =  -midT1(Rind1less) + midT1(Rind1Jimax)
T2over1 =  -midT2(Rind2less) + midT2(Rind2Jimax)
% arrays oversampled
clear T1overarr1
clear T2overarr1
for jj=1:NstepR1+1
  T1overarr1(jj)= midT1(Rind1less) + T1over1*dRover1*(jj-1);
  T2overarr1(jj)= midT2(Rind2less) + T2over1*dRover1*(jj-1);
end


% 2025-05-16
% ROI oversampled2
stepR = 0.1
Rover2 =  R1sort(maxJi):stepR:R1(Rind1more)
Rtotover2 = - R1sort(maxJi) + R1(Rind1more)
dRover2 = stepR / Rtotover2
NstepR2 = round(Rtotover2 / stepR)
T1over2 = midT1(Rind1more) - midT1(Rind1Jimax)
T2over2 = midT2(Rind2more) - midT2(Rind2Jimax)
% arrays oversampled
clear T1overarr2
clear T2overarr2
for jj=1:NstepR2+1
  T1overarr2(jj)= midT1(Rind1Jimax) + T1over2*dRover2*(jj-1);
  T2overarr2(jj)= midT2(Rind2Jimax) + T2over2*dRover2*(jj-1);
end

