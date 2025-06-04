% Created: 2021-11-23
% NEW 2022-06-03
% LAST 2022-06-21
function [mode, mu_array, max_mu, mode_ind, c_array, C, multi]= modeIR4(X)
% mode
% mu_array    union of max_mu
% max_mu      max frequency of c
% mode_ind    indexes of mode in c_array
% c_array     intervals of end, intersections count always
% C           ends of intervals, intersections count always
% multi
% INI
mu_array=[]; mode_ind=[]; c_array=[]; C=[];  multi=0;
%
% X=PgammaStdNow
% X=DataStdCover
% X=DataStd
% 2022-06-18
% X = XCover
 % 2022-07-16
% 2022-09-16
% X = XY;
% make X
[m, n] = size(X) ;
if m>1 X=X'
 end
%
I=intersect(X(:));
if not(isempty(I))
   display('cover set')
   mode=I; max_mu=length(X); multi=1;
 endif
%
C=[inf(X) sup(X)];
C=sort(C);
for ii=1:length(C)-1
  c(ii)=infsupdec(C(ii),C(ii+1));
end
c_array=c;
display(c);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% mu = ? %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tic
clear mu;
for ii=1:(length(C)-1)
mu(ii)=0;
% check c subset X
  for jj=1:length(X)
%      if not(isempty(intersect(c(ii), X(jj))))
      if inIR(c(ii), X(jj)) > 0
        mu(ii)=mu(ii)+1;
      end
% jj
end
%ii
if  (mod(ii, 100) == 0) ii; end
end
%toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% mu = ? %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% /check c subset X
mu_array=mu;
[max_mu,max_mu_ind]=max(mu_array);
mode=[];
mode_ind=[];
multi=0;
%
for ii=1:length(c)
  if mu_array(ii)== max_mu
    multi=multi+1;
    mode=[mode, c(ii)];
    mode_ind=[mode_ind, ii];
  endif
end
%

endfunction
