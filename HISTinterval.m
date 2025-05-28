% 2025-05-28
% IntervalHIST
RinvGmidOUT = Routmid(BtIpIntInd)
RinvGradOUT = Routrad(BtIpIntInd)

X = midrad(RinvGmidOUT, RinvGradOUT)
% W = ?
nbins = 8
##minC12 = min( inf(X) ), maxC12 = max( sup(X) ), midC12 = ( min( inf(X) )+ max( sup(X) ) )/2,
##clear C, C = [  infsup(minC12, midC12), infsup(midC12, maxC12)  ]
##C4 = []
##C4 = [C4,  infsup(minC12, minC12+ (midC12-minC12)/2) ]
##C4 = [C4, infsup( minC12+ (midC12-minC12)/2, midC12) ]
##C4 = [C4, infsup( midC12, midC12+ (maxC12 - midC12)/2) ]
##C4 = [C4, infsup( midC12+ (maxC12 - midC12)/2,  maxC12) ]
##W = C4
% [CXwid]= XinCrel(X, C4)
stepW = (max(sup(X)) -min(inf(X)))/ (nbins)
%Wterm = min(inf(dataIR)) : stepW : max(sup(dataIR))
for jj=1:nbins
  W(jj) =  infsup(min(inf(X))+stepW*(jj-1), min(inf(X)) + stepW*jj);
 % infsup(min(inf(dataIR))+stepW*ii, min(inf(dataIR)) + stepW*(ii+1)) ]
end
%
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
##RestINN = infsup(inf(W(Q1less+1)), sup(W(Q3more-1)))
##RestOUT = infsup(inf(W(1)), sup(W(end)))
RestINN = infsup(inf(W(Q1less(end)+1)), sup(W(Q3more(1)-1)))
RestOUT = infsup(inf(W(1)), sup(W(end)))
RestINNarray = [RestINNarray, RestINN ]
RestOUTarray = [RestOUTarray, RestOUT ]
%
errorbar(mean(BtIpInt(BtIpIntInd)), mid(RestOUT), rad(RestOUT),"~.r");
errorbar(mean(BtIpInt(BtIpIntInd)), mid(RestINN), rad(RestINN),"~.b");
