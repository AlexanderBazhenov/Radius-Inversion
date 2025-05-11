% 2025-05-09
% Find Rinv interval

% R > 35
[R35more1] = find(R(ShotTimeROIind1)>35)
[R35more2] = find(R(ShotTimeROIind2)>35)
ShotTimeROIind1  = ShotTimeROIind1(R35more1);
ShotTimeROIind2  = ShotTimeROIind2(R35more2);

midT1 = Te(ShotTimeROIind1);
radT1 = 0.05*midT1;
Tint1 = midrad(midT1, radT1);
midT2 = Te(ShotTimeROIind2);
radT2 = 0.05*midT2;
Tint2 = midrad(midT2, radT2);

% array of radiuses
R1 = R(ShotTimeROIind1)
R2 = R(ShotTimeROIind2)
% common points in R1 R2
% 8 points
[R12, I1, I2] = intersect(R1, R2)

##figure
##hold on
##plot(R(ShotTimeROIind1), midT1, 'sb')
##plot(R(ShotTimeROIind2), midT2, 'sr')



##figure
##hold on
##plot(R1, midT1, 'sb')
##plot(R2, midT2, 'sr')

% sort R1 R2
[R1sort, I1sort] = sort(R1(I1))
[R2sort, I2sort] = sort(R2(I2))

##figure
##hold on
##plot(R1sort, midT1(I1), 'sb')
##plot(R2sort, midT2(I2), 'sr')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T2 < T1
T2less = find(midT2(I2) < midT1(I1))
T2more = find(midT2(I2) > midT1(I1))
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

##figure
##hold on
##plot(R1sort, midT1(I1), 'sb')
##plot(R2sort, midT2(I2), 'sr')
##xx = [ R1(Rind1less) R1(Rind1more) ]
##yy = [ midT1(Rind1less) midT1(Rind1more) ]
##plot(xx, yy, '-b')
##xx = [ R2(Rind2less) R2(Rind2more) ]
##yy = [ midT2(Rind2less) midT2(Rind2more) ]
##plot(xx, yy, '-r')

% ROI oversampled
stepR = 0.1
Rover =  R1(Rind1less):stepR:R1(Rind1more)
Rtotover = R1(Rind1more) - R1(Rind1less)
dRover = stepR / Rtotover
NstepR = round(Rtotover / stepR)
T1over =  midT1(Rind1more) - midT1(Rind1less)
T2over =  midT2(Rind2more) - midT2(Rind2less)
% arrays oversampled
for jj=1:NstepR+1
  T1overarr(jj)= midT1(Rind1less) + T1over*dRover*(jj-1);
  T2overarr(jj)= midT2(Rind2less) + T2over*dRover*(jj-1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##% PlotROI
##figure
##hold on
##plot(R1sort, midT1(I1), 'sb')
##plot(R2sort, midT2(I2), 'sr')
##xx = [ R1(Rind1less) R1(Rind1more) ]
##yy = [ midT1(Rind1less) midT1(Rind1more) ]
##plot(xx, yy, '-b')
##xx = [ R2(Rind2less) R2(Rind2more) ]
##yy = [ midT2(Rind2less) midT2(Rind2more) ]
##plot(xx, yy, '-r')
##plot(Rover, T1overarr, '.b')
##plot(Rover, T2overarr, '.r')
##% /PlotROI
%
midT1over = T1overarr;
radT1over = 0.05*midT1over;
Tint1over = midrad(midT1over, radT1over);
midT2over = T2overarr;
radT2over = 0.05*midT2over;
Tint2over = midrad(midT2over, radT2over);
%
x1 = Tint1over;
x2 = Tint2over;
%%%%%%%%%%%%%%%%%%%%%%%%%%% find Jaccard index Te1, Te2 %%%%%%%%%%%%%%%%%%%%%%%
for jj = 1:length(Rover)
% jaccard Te1 Te2
  [x1cap, x2cap]=wedge(Tint1over(jj), Tint2over(jj));
  [x1cup, x2cup]=vee(Tint1over(jj), Tint2over(jj));
  out=(x2cap-x1cap)/abs(x1cup-x2cup);
  JiT1T2over(jj) = out;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rinv in R
[maxJiT1T2over, maxJiT1T2overind] =  max(JiT1T2over)
RinvR = Rover(maxJiT1T2overind);
% Rinv in IR
RinvOutInn;
##RinvINN = infsup(Rinvoutinf, Rinvoutsup)
##RinvOUT = infsup(Rinvinninf, Rinvinnsup)
% 2025-05-11
% PlotRinvOutInn

