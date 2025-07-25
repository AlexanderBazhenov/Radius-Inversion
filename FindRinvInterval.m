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
%
figure
hold on
plot(midT1)
plot(midT2)
% array of radiuses
R1 = R(ShotTimeROIind1)
R2 = R(ShotTimeROIind2)
% common points in R1 R2
% 8 points
[R12, I1, I2] = intersect(R1, R2)
% sort R1 R2
[R1sort, I1sort] = sort(R1(I1))
[R2sort, I2sort] = sort(R2(I2))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-06-09
% Brute force oversampling

figure
hold on
plot(R12, mid(Tint1(I1)), 'sb')
plot(R12, mid(Tint2(I2)), 'sr')

T1overarr = []
T2overarr = []
Rover = []
%
stepR = 0.1
for kk = 1:length(R12)-1
Rmin = R12(kk)
Rmax = R12(kk+1)
%
Rover1 =  Rmin:stepR:Rmax
Rtotover1 = Rmax - Rmin
dRover1 = stepR / Rtotover1
NstepR1 = round(Rtotover1 / stepR)
T1over1 =  -mid(Tint1(I1(kk))) + mid(Tint1(I1(kk+1)))
T2over1 =  -mid(Tint2(I2(kk))) + mid(Tint2(I2(kk+1)))
% arrays oversampled
clear T1overarr1
clear T2overarr1
for jj=1:NstepR1+1
  T1overarr1(jj)= mid(Tint1(I1(kk+1))) + T1over1*dRover1*(jj-1);
  T2overarr1(jj)= mid(Tint2(I2(kk+1))) + T2over1*dRover1*(jj-1);
end
% Join Rover1 Rover2
##Rover = [Rover1 Rover2(2:end)]
T1overarr = [ T1overarr T1overarr1]; %(2:end)]
T2overarr = [ T2overarr T2overarr1]; %(2:end)]
Rover = [ Rover Rover1];
end
% Brute force oversampling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hold on
plot(Rover, T1overarr, '-b')
plot(Rover, T2overarr, '-r')
plot(R(ShotTimeROIind1), Te(ShotTimeROIind1), '.bs');
plot(R(ShotTimeROIind1), Te(ShotTimeROIind1), '-b');
plot(R(ShotTimeROIind2), Te(ShotTimeROIind2), '.rs');
plot(R(ShotTimeROIind2), Te(ShotTimeROIind2), '-r');



clear JiT1T2
%if I1sort == I2sort
  for jj = 1:length(I1)
% jaccard Te1 Te2
    [x1cap, x2cap]=wedge(Tint1(I1(jj)), Tint2(I2(jj)));
    [x1cup, x2cup]=vee(Tint1(I1(jj)), Tint2(I2(jj)));
    out=(x2cap-x1cap)/abs(x1cup-x2cup);
    JiT1T2(jj) = out;
  end
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT Jaccard index Te1, Te2
##figure
##hold on
##plot(JiT1T2, 'ok')
##% find max Ji in the middle of arrays
[maxJiT1T2, maxJiT1T2ind] = max(JiT1T2(2:end-1))
% maxJiT1T2ind - index in R12 cropped
% maxJi - index in R12
maxJi = maxJiT1T2ind + 1
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  R(ShotTimeROIind1(I1(maxJi))) =  R(ShotTimeROIind2(I2(maxJi)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rinv in R
if maxJiT1T2 > 0
  RinvR = R1(maxJi);
end
% 2025-05-14
T2less = find(midT2(I2) < midT1(I1))
T2more = find(midT2(I2) > midT1(I1))
% max Ji elimination
T2less = setdiff(T2less, maxJi)
T2more = setdiff(T2more, maxJi)
% 3 points for ROI
PointsROI3
%
ROIoversampled12
%

% PLOT ROI oversampled1 2
figure
hold on
plot(R1sort, midT1(I1), 'sb')
plot(R2sort, midT2(I2), 'sr')
xx = [ R1(Rind1less) R1sort(maxJi) R1(Rind1more) ]
yy = [ midT1(Rind1less) midT1(Rind1Jimax) midT1(Rind1more) ]
plot(xx, yy, '-b')
xx = [ R2(Rind2less) R2sort(maxJi) R2(Rind2more) ]
yy = [ midT2(Rind2less) midT2(Rind2Jimax) midT2(Rind2more) ]
plot(xx, yy, '-r')
xlim([R2(Rind2less) R2(Rind2more)] )
ylim( [ midT1(Rind1more)  midT1(Rind1less)  ] )
set(gca, 'fontsize', 14)
xlabel('R')
ylabel('Te')
  titlestr = strcat('Te vs R ROIover oversampled')
title(titlestr)
% 1 part
plot(Rover1, T1overarr1, '.b')
plot(Rover1, T2overarr1, '.r')
% 2 part
plot(Rover2, T1overarr2, '.b')
plot(Rover2, T2overarr2, '.r')
%
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Join Rover1 Rover2
Rover = [Rover1 Rover2(2:end)]
T1overarr = [ T1overarr1 T1overarr2(2:end)]
T2overarr = [ T2overarr1 T2overarr2(2:end)]
%
%else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##% T2 < T1
##T2less = find(midT2(I2) < midT1(I1))
##T2more = find(midT2(I2) > midT1(I1))
##%
##
##% R less more
##[R1maxT2less, R1maxT2lessInd] = max(R1sort(T2less))
##[R1minT2more, R1maxT2moreInd] = min(R1sort(T2more))
##[R2maxT2less, R2maxT2lessInd] = max(R2sort(T2less))
##[R2minT2more, R2maxT2moreInd] = min(R2sort(T2more))
##% T(R)  less more
##% less
##Rind1less =find(R(ShotTimeROIind1) == R1maxT2less)
##midT1(Rind1less)
##Rind2less =find(R(ShotTimeROIind2) == R2maxT2less)
##midT2(Rind2less)
##% more
##Rind1more =find(R(ShotTimeROIind1) == R1minT2more)
##midT1(Rind1more)
##Rind2more =find(R(ShotTimeROIind2) == R2minT2more)
##midT2(Rind2more)
##
##
##
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
##
##% ROI oversampled
##stepR = 0.1
##Rover =  R1(Rind1less):stepR:R1(Rind1more)
##Rtotover = R1(Rind1more) - R1(Rind1less)
##dRover = stepR / Rtotover
##NstepR = round(Rtotover / stepR)
##T1over =  midT1(Rind1more) - midT1(Rind1less)
##T2over =  midT2(Rind2more) - midT2(Rind2less)
##% arrays oversampled
##for jj=1:NstepR+1
##  T1overarr(jj)= midT1(Rind1less) + T1over*dRover*(jj-1);
##  T2overarr(jj)= midT2(Rind2less) + T2over*dRover*(jj-1);
##end
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%% find Jaccard index Te1, Te2 %%%%%%%%%%%%%%%%%%%%%%%
clear JiT1T2over
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

