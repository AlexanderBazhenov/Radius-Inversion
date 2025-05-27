%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-05-27
% Nick Mordovin results
DATARint = csvread("interval_inversion.csv")
% read results
ShotInt = DATARint (2:end, 1);
Rinnmid = DATARint (2:end, 2);
Rinnrad = DATARint (2:end, 3);
Routmid = DATARint (2:end, 4);
Routrad = DATARint (2:end, 5);
BtInt = DATARint (2:end, 6);
IpInt = DATARint (2:end, 7);
for ii = 1:length(ShotInt)
  BtIpInt(ii)=  BtInt (ii) / IpInt(ii);
end
%
figure
hold on
errorbar(BtIpInt, Rinnmid, Rinnrad,"~.b");
errorbar(BtIpInt, Routmid, Routrad,"~.r");
p1 = plot(BtIpInt, Rinnmid, 'sb')
p2 = plot(BtIpInt, Routmid, 'sr')
 lgd12 = legend([p1 p2 ], ...
  {'Inn', 'Out'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'east');
set(gca, 'fontsize', 14)
xlabel('BT/Ip')
ylabel('Rinv')
grid on
##titlestr = strcat('Rinv vs BpIp interval Inn Out')
##title(titlestr)
##figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd

%figure
hist(BtIpInt, 40)
%
xxBtIp = [0.0018 0.0022 0.0024 0.0026 0.00275 0.00295 0.0032 0.0034 0.00355 0.00365 0.0039 ]
for ii = 1 : length (xxBtIp)
  xx = [xxBtIp(ii) xxBtIp(ii)]
  yy = [0 60 ]
  plot(xx, yy, '--k')
end
%
##xx = [0.0018 0.0018]
##yy = [0 60 ]
##plot(xx, yy, '--k')
##xx = [0.0022 0.0022]
##plot(xx, yy, '--k')
##xx = [0.0024 0.0024]
##plot(xx, yy, '--k')
##xx = [0.0026 0.0026]
##plot(xx, yy, '--k')
##xx = [0.00275 0.00275]
##plot(xx, yy, '--k')
##xx = [0.00295 0.00295]
##plot(xx, yy, '--k')
##xx = [0.0032 0.0032]
##plot(xx, yy, '--k')
##xx = [0.0034 0.0034]
##plot(xx, yy, '--k')
##xx = [0.00355 0.00355]
##plot(xx, yy, '--k')
##xx = [0.00365 0.00365]
##plot(xx, yy, '--k')
titlestr = strcat('Rinv by BpIp interval Inn Out')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hold on
errorbar(BtIpInt, Routmid, Routrad,"~.k");
for ii = 1 : length (xxBtIp)
  xx = [xxBtIp(ii) xxBtIp(ii)]
  yy = [40 60 ]
  plot(xx, yy, '--k')
end

ii = 1
[BtIpIntInd] = find(BtIpInt > xxBtIp(ii) & BtIpInt < xxBtIp(ii+1))
RinvGmidOUT = Routmid(BtIpIntInd)
RinvGradOUT = Routrad(BtIpIntInd)

X = midrad(RinvGmidOUT, RinvGradOUT)
minC12 = min( inf(X) ), maxC12 = max( sup(X) ), midC12 = ( min( inf(X) )+ max( sup(X) ) )/2,
clear C, C = [  infsup(minC12, midC12), infsup(midC12, maxC12)  ]
C4 = []
C4 = [C4,  infsup(minC12, minC12+ (midC12-minC12)/2) ]
C4 = [C4, infsup( minC12+ (midC12-minC12)/2, midC12) ]
C4 = [C4, infsup( midC12, midC12+ (maxC12 - midC12)/2) ]
C4 = [C4, infsup( midC12+ (maxC12 - midC12)/2,  maxC12) ]
W = C4
% [CXwid]= XinCrel(X, C4)
tmp = XinCrel(X, W);
XbyC = sum(tmp, 2);
%
sum(XbyC)
HistXbyC = XbyC/sum(XbyC)
cumsumHistXbyC = cumsum(HistXbyC)
% find Quartiles
Q1less = find(cumsumHistXbyC < .25)
Q3more = find(cumsumHistXbyC > .75)
%
RestINN = infsup(inf(W(Q1less+1)), sup(W(Q3more-1)))
RestOUT = infsup(inf(W(1)), sup(W(end)))

errorbar(mean(BtIpInt(BtIpIntInd)), mid(RestOUT), rad(RestOUT),"~.r");
errorbar(mean(BtIpInt(BtIpIntInd)), mid(RestINN), rad(RestINN),"~.b");
xlim([0.0015 0.004])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




