clear all;clc;close all
lb=[-5,-5];   %兩組基因的蛋白質範圍的最小值
ub=[5,5];     %兩組基因的蛋白質範圍的最大值
range =[lb;ub];
var_n=size(range,2);
island=1;     %一個島
popuSize=60; %人口(染色體)/每島
bit_n=50;     %一組基因的長度，等位基因alleles，所以每組基因長度皆相同
popu=GA_initpopu(popuSize, bit_n, var_n);%螞蟻(產生族群)

c1=popu(1,:);
c2=popu(2,:);
g1=popu(1,1:bit_n);
g2=popu(1,(bit_n+1):(bit_n*2));
p1=popu(1,1);
p2=popu(1,2);

%計算每隻螞蟻的輸入In及輸出Out
fcn='ObjFcn1';

%計算每隻螞蟻的價值、分數性能: 適應函數
for i=1:size(popu,1)
   [fitness(i), ~] = GA_evaleachreal(popu(i,:), bit_n, range, fcn);
end

%下一代螞蟻(子代)物競天擇(用俄羅斯輪盤來選擇)+交配
xover_rate=0.8;
%[新人口(子代)，子代中第一強者,第二強者]
[new_popu, elitism] = Selection(popu, bit_n, fitness, xover_rate);
% new_popu = 子代人口，與父母數量相同
