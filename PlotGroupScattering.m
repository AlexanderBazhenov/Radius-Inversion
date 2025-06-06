% 2025-06-05
% 2025-06-06 - порог THR = 3
 x = BtIpIntInd(indradTHR)
 y =   RinvGmidOUT
 epsilon =  RinvGradOUT
 xind = 1:length(x)

figure
errorbar(xind, y, epsilon,"~.b");
set(gca, 'fontsize', 14)
xlabel('Number')
ylabel('Rinv')
titlestr = strcat('Rinv scatter', ' Max datum radius=', num2str(radTHR), ' Group number=', num2str(ii))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd


figure
errorbar (y, xind, epsilon, epsilon,">.b");
set(gca, 'fontsize', 14)
ylabel('Number')
xlabel('Rinv')
titlestr = strcat('Rinv scatter', ' Max datum radius=', num2str(radTHR), ' Group number=', num2str(ii))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, ' horizontal', '.png')
print('-dpng', '-r300', figure_name_out), pwd

% 2025-06-06
% nbins = 8*2 = 16
figure
hold on
##plot(mid(W), HistXbyC, 'sb')
##plot(mid(W), HistXbyC, '--b')

for jj=1:length(W)
  xx = [inf(W(jj)) sup(W(jj))]
yy = [ HistXbyC(jj) HistXbyC(jj) ]
plot(xx, yy, '-k')
  xx = [inf(W(jj)) inf(W(jj))]
yy = [ 0 HistXbyC(jj) ]
plot(xx, yy, '-k')
  xx = [sup(W(jj)) sup(W(jj))]
  plot(xx, yy, '-k')
end
set(gca, 'fontsize', 14)
ylabel('Weight')
xlabel('Rinv')
titlestr = strcat('Rinv HIST', ' Max datum radius=', num2str(radTHR), ' nbins=', num2str(nbins), ' Group number=', num2str(ii))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
xlim ([min(inf(W)) max(sup(W))] )
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

figure
hold on
plot(mid(W), cumsumHistXbyC, 'sb')
plot(mid(W), cumsumHistXbyC, '-b')
set(gca, 'fontsize', 14)
ylabel('Weight')
xlabel('Rinv')
titlestr = strcat('Rinv INN', ' Max datum radius=', num2str(radTHR),  ' nbins=', num2str(nbins), ' Group number=', num2str(ii))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
%
xx = [min(mid(W)) max(mid(W))]
yy = [.25 .25]
plot(xx, yy, '--k')
yy = [.75 .75]
plot(xx, yy, '--k')
% подгониан по xx
xx = [52.06 52.06 ]
yy = [0 0.25]
plot(xx, yy, '--k')
xx = [53.41 53.41]
yy = [0 0.75]
plot(xx, yy, '--k')
%
xx = [52.06 53.41]
yy = [0.01 0.01]
h = plot(xx, yy, '-r')
set(h, 'linewidth', 4)
%
xlim ([min(mid(W)) max(mid(W))] )
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

