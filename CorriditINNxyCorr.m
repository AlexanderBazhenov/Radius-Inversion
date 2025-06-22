% 2025-06-20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for kk = 1: length(xxBtIp)-1
  [BtIpIntInd] = find(BtIpInt > xxBtIp(kk) & BtIpInt < xxBtIp(kk+1))
  if (length(BtIpIntInd) > 0 )
     meanW(kk) = (min(BtIpInt(BtIpIntInd)) + max(BtIpInt(BtIpIntInd)))/2
    infWint(kk) = min(BtIpInt(BtIpIntInd))
    supWint(kk) = max(BtIpInt(BtIpIntInd))
  end
end

x = meanW';        # количество затраченного топлива
y =  mid(RestINNarray);        # объем произведенного пара
epsilon = rad(RestINNarray);  # верхняя граница ошибки для y_i
indNaN  = isnan(mid(RestINNarray))
x(indNaN) = []
y(indNaN) = []
infWint(indNaN) = []
supWint(indNaN) = []
epsilon(indNaN) = []
infy = y - epsilon
supy = y + epsilon

X = [ x.^0 x ];               # матрица значений переменных при beta1 и beta2
infX = [ x.^0 infWint' ];
supX = [ x.^0 supWint' ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[tolmax,argmax, env] = tolsolvty(infX,supX,infy',supy',1);
%
tolneg = find(env(:,2)<0)
eqnumber = env(:,1)
eqtol = env(:,2)
%
figure
hold on
p1 = plot(eqnumber, eqtol,'sk')
p2 = plot(eqnumber(tolneg), eqtol(tolneg),'sr')
 lgd12 = legend([p1 p2 ], ...
  {'Pos', 'Neg'})
  set(lgd12, 'fontsize', 14);
%    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Eq number')
ylabel('Tol eq')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Tol Rinv Inn ',  ' Max datum radius=', num2str(radTHR))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%
figure
hist(eqtol)
set(gca, 'fontsize', 14)
ylabel('Eq count')
xlabel('Tol eq')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
titlestr = strcat('Tol HIST Rinv Inn ',  ' Max datum radius=', num2str(radTHR))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0 = BtIpInt'
X0 = [ x0.^0 x0 ];
[tolmax0,argmax0, env0] = tolsolvty(X0,X0,Rinnmid-Rinnrad,Rinnmid+Rinnrad,1);
for ii=1:length(X0)
  ytol(ii) = argmax(1) + argmax(2)*X0(ii, 2);
end
figure
hold on
errorbar(BtIpInt, Rinnmid, Rinnrad,"~.b");
p1 = plot(BtIpInt, Rinnmid, 'sb')
p2 = plot(BtIpInt, ytol, 'sr')
plot(BtIpInt, ytol, '-r')
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
eqnumber0 = env0(:,1)
eqtol0 = env0(:,2)
%
figure
hold on
p1 = plot(eqnumber0, eqtol0,'sk')
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[tolmax1,argmax1, env1] = tolsolvty(X0,X0,Routmid-Routrad,Routmid+Routrad,1);
for ii=1:length(X0)
  ytol1(ii) = argmax1(1) + argmax1(2)*X0(ii, 2);
end
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

titlestr = strcat('RSV INN-OUT BtIp 2')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
