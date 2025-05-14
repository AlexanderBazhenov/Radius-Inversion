% 2025-05-14
% 2025-04-30
Bt = DATA (:, 7);
Ip = DATA (:, 6);
for ii = 1:length(DATA)
  BtIp(ii)=  Bt (ii) / Ip(ii);
end

figure
hist(BtIp, 20)
xlim([0.0015 0.009])
set(gca, 'fontsize', 14)
ylabel('Count')
xlabel('Bt div Ip')
  titlestr = strcat('HIST Bt div Ip')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

figure
plot(BtIp)
xlim([0 length(DATA)])
ylim([min(BtIp)*0.9 max(BtIp)*1.1])
set(gca, 'fontsize', 14)
xlabel('Count')
ylabel('Bt div Ip')
  titlestr = strcat('Bt div Ip')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

