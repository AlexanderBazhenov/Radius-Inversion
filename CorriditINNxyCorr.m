% 2025-06-20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%   INN      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% argmax
x0 = BtIpInt'
X0 = [ x0.^0 x0 ];
[tolmax0,argmax0, env0] = tolsolvty(X0,X0,Rinnmid-Rinnrad,Rinnmid+Rinnrad,1);
%
for ii=1:length(X0)
  ytol0(ii) = argmax0(1) + argmax0(2)*X0(ii, 2);
end
%
figure
hold on
errorbar(BtIpInt, Rinnmid, Rinnrad,"~.b");
p1 = plot(BtIpInt, Rinnmid, 'sb')
p2 = plot(BtIpInt, ytol0, 'sr')
plot(BtIpInt, ytol0, '-r')
 lgd12 = legend([p1 p2 ], ...
  {'Data INN', 'argmaxtol'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Bt/Ip')
ylabel('Rinv')
grid on
titlestr = strcat('Rinv vs BtIp interval Inn argmax')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

eqnumber0 = env0(:,1)
eqtol0 = env0(:,2)
figure
hist(eqtol0, 30)
set(gca, 'fontsize', 14)
ylabel('Eq count')
xlabel('Tol eq')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Tol HIST Rinv Inn ')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

tolneg0 = find(env0(:,2)<0)
tolpos0 = find(env0(:,2)>=0)
eqnumber0 = env0(:,1)
eqtol0 = env0(:,2)
%
figure
hold on
%p1 = plot(eqnumber0, eqtol0,'sk')
p1 = plot(eqnumber0(tolpos0), eqtol0(tolpos0),'sk')
p2 = plot(eqnumber0(tolneg0), eqtol0(tolneg0),'sr')
 lgd12 = legend([p1 p2 ], ...
  {'Pos', 'Neg'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'northwest');
set(gca, 'fontsize', 14)
xlabel('Eq number')
ylabel('Tol eq')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Tol Rinv INN ',  ' Pos Neg')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
 figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

figure
hold on
p1 = plot(BtIpInt(eqnumber0), eqtol0,'sk')
p2 = plot(BtIpInt(eqnumber0(tolneg0)), eqtol0(tolneg0),'sr')
%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMMON
 lgd12 = legend([p1 p2 ], ...
  {'Pos', 'Neg'})
  set(lgd12, 'fontsize', 14);
%    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Eq number')
ylabel('Tol eq')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%% /COMMON
titlestr = strcat('Tol Rinv BtIp INN ',  ' Pos Neg')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%   /INN      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%   OUT      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[tolmax1,argmax1, env1] = tolsolvty(X0,X0,Routmid-Routrad,Routmid+Routrad,1);
for ii=1:length(X0)
  ytol1(ii) = argmax1(1) + argmax1(2)*X0(ii, 2);
end
%
figure
hold on
errorbar(BtIpInt, Routmid, Routrad,"~.b");
p1 = plot(BtIpInt, Routmid, 'sb')
p2 = plot(BtIpInt, ytol1, 'sr')
plot(BtIpInt, ytol1, '-r')
 lgd12 = legend([p1 p2 ], ...
  {'Data OUT', 'argmaxtol'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Bt/Ip')
ylabel('Rinv')
grid on
titlestr = strcat('Rinv vs BtIp interval Out argmax')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd


eqnumber1 = env1(:,1)
eqtol1 = env1(:,2)
figure
hist(eqtol1, 30)
set(gca, 'fontsize', 14)
ylabel('Eq count')
xlabel('Tol eq')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Tol HIST Rinv Out ')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

tolneg1 = find(env1(:,2)<0)
eqnumber1 = env1(:,1)
eqtol1 = env1(:,2)
%
figure
hold on
p1 = plot(eqnumber1, eqtol1,'sk')
p2 = plot(eqnumber1(tolneg1), eqtol1(tolneg1),'sr')
%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMMON
 lgd12 = legend([p1 p2 ], ...
  {'Pos', 'Neg'})
  set(lgd12, 'fontsize', 14);
%    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Eq number')
ylabel('Tol eq')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%% /COMMON
titlestr = strcat('Tol Rinv OUT ',  ' Pos Neg')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

figure
hold on
p1 = plot(BtIpInt(eqnumber1), eqtol1,'sk')
p2 = plot(BtIpInt(eqnumber1(tolneg1)), eqtol1(tolneg1),'sr')
%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMMON
 lgd12 = legend([p1 p2 ], ...
  {'Pos', 'Neg'})
  set(lgd12, 'fontsize', 14);
%    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Eq number')
ylabel('Tol eq')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%% /COMMON
titlestr = strcat('Tol Rinv BtIp OUT ',  ' Pos Neg')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%     RSV   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for ii = 1:length(Rinnmid)
  Rinnintarray (ii)  = midrad(Rinnmid(ii), Rinnrad(ii));
  Routintarray (ii)  = midrad(Routmid(ii), Routrad(ii));
end
%
for ii = 1:length(Rinnmid)
  p = Rinnintarray (ii);
  q = Routintarray (ii);
  RSVarray (ii) = RSV(p,q);
end
%
figure
plot(BtIpInt, RSVarray, 'sk')
xlabel('Bt/Ip')
ylabel('RSV')
set(gca, 'fontsize', 14)
grid on
%
titlestr = strcat('RSV INN-OUT BtIp')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

ylim([0 2.1])
titlestr = strcat('RSV INN-OUT BtIp 2')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
