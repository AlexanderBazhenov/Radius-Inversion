% 2025-02-19
clear all
close all
%
dirroot ='e:\Users\Public\Documents\ST\2025\T\'
dir2023 ='e:\Users\Public\Documents\ST\2023\T\'
dir2022 =  'e:\Users\Public\Documents:\ST\2022\T\'
dirki ='e:\Users\Public\Documents\ST\2024\T\kinterval-0.0.1\'
dir2D = 'e:\Users\Public\Documents\ST\2024\T\IntLinInc2D\'
% HomePC
##dirroot = 'D:\ST\2025\T\'
##dirki = 'D:\ST\2024\T\kinterval-0.0.1'
##dirData = 'D:\ST\2024\T\DRS4\'
##dir2023 =  'd:\ST\2023\T\'
##dir2022 =  'd:\ST\2022\T\'
%
addpath(dirroot)
addpath(dir2023)
addpath(dir2022)
addpath(dirki)
%addpath(dir2D)



cd(dirroot), pwd



pkg load interval
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST Sonya %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
W = [
infsup(1, 4.5), infsup(4.5, 8), infsup(8, 10)
]
%
X = [ infsup(1,6), infsup(2, 5), infsup(3, 4), infsup(8, 10) ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp = XinCrel(X, W);
XbyC = sum(tmp, 2);
%
sum(XbyC)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST 1cell %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data =  [8185 8200 8195 8185 8195 8196 8180 8192 8221 8179 8196 8162 8197 8188 8170 8187 8163 8196 8157 8188 8158 8163 8199 8162 8162 8186 8207 8154 8213 8200 8200 8180 8178 8179 8189 8169 8192 8168 8200 8161 8196 8153 8193 8180 8162 8186 8164 8191 8199 8171 8168 8189 8186 8190 8190 8154 8174 8186 8196 8198 8189 8199 8194 8170 8190 8195 8187 8156 8173 8171 8198 8168 8187 8187 8160 8221 8205 8158 8190 8156 8210 8194 8211 8196 8190 8203 8199 8186 8161 8187 8161 8184 8200 8178 8186 8184 8192 8189 8200 8182]
figure
hist(data)

raddata = 8%/16
for ii=1:length(data)
  dataIR(ii) = midrad(data(ii), raddata);
end

min(inf(dataIR))
max(sup(dataIR))
nbins = 10
stepW = (max(sup(dataIR)) -min(inf(dataIR)))/ (nbins)
Wterm = min(inf(dataIR)) : stepW : max(sup(dataIR))

for ii=1:nbins
  W(ii) =  infsup(min(inf(dataIR))+stepW*(ii-1), min(inf(dataIR)) + stepW*ii);
 % infsup(min(inf(dataIR))+stepW*ii, min(inf(dataIR)) + stepW*(ii+1)) ]
end

tmp = XinCrel(dataIR, W);
XbyC = sum(tmp, 2);
sum(XbyC)

figure
plot(Wterm(1:end-1), XbyC)
grid on
set(gca, 'fontsize', 14)
xlabel('\it count')
xlabel('\it ADC Code')
titlestr = strcat('Interval hist', ' rad=', num2str(raddata))
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

##def create_intervals(data):
##    # Преобразуем числа в интервалы [a-1, a+1]
##    intervals = [(a - 1, a + 1) for a in data]
##    return intervals
##
##
##def calculate_intersection_width(w, x):
##    # Вычисляем ширину пересечения интервалов w и x
##    lower_bound = max(w[0], x[0])
##    upper_bound = min(w[1], x[1])
##    return max(0, upper_bound - lower_bound)
##
##
##def calculate_matrix(intervals, bins):
##    # Создаем матрицу отношений
##    matrix = np.zeros((len(bins) - 1, len(intervals)))
##    for i in range(len(bins) - 1):
##        w = (bins[i], bins[i + 1])
##        for j, x in enumerate(intervals):
##            intersection_width = calculate_intersection_width(w, x)
##            x_width = x[1] - x[0]
##            if x_width > 0:
##                matrix[i, j] = intersection_width / x_width
##    return matrix
##
##
##def calculate_histogram(matrix):
##    # Суммируем значения по строкам матрицы
##    return np.sum(matrix, axis=1)
##
##
##def plot_histogram(bins, hist):
##    # Построение гистограммы
##    plt.bar(bins[:-1], hist, width=np.diff(bins), edgecolor="black", align="edge")
##    plt.xlabel('Бины')
##    plt.ylabel('Суммы по строкам')
##    plt.title('Гистограмма распределения частот')
##    plt.show()


