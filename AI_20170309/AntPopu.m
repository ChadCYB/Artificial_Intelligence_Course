clear all; clc; close all
lb=[-5,-5]; %兩組基因的蛋白質範圍的最小值
ub=[5,5]; %兩組基因的蛋白質範圍的最大值
range=[lb;ub];
var_n=size(range,2); 
island=1; %1個島
popuSize=100; %人口(染色體)/每島
bit_n=40; %一組基因的長度，等位基因alleles，所以每組基因長度皆相同
popu=GA_initpopu(popuSize, bit_n, var_n);
c1=popu(1,:); %第一隻螞蟻的染色體chromesome(genes)
c2=popu(2,:); %第二隻螞蟻
g1=popu(1,1:bit_n); %第一隻螞蟻的第一組基因(gene#1)
g2=popu(1,(bit_n+1):(bit_n*2)); %第一隻螞蟻的第二組基因(gene#2)
p1=popu(1,1); %第一隻螞蟻的第一個蛋白質(protein#1)
p2=popu(1,2); %第一隻螞蟻的第二個蛋白質(protein#2)
disp(['The first gene of the first ant.(gene#1): ', num2str(g1)])

%個體多樣性指標，For loop每一隻螞蟻都和第一隻的基因比較(相減後取絕對值)
for i=2:size(popu,1)
    g1i=popu(i,1:bit_n);
    g2i=popu(i,(bit_n+1):(bit_n*2));
    DI1(i-1)=sum(abs(g1i-g1));
    DI2(i-1)=sum(abs(g2i-g2));
end
%plot(x,y) x:2~len(DI1)+1, y:DI1數據
figure, plot(2:(length(DI1)+1),DI1,'r',2:(length(DI2)+1),DI2,'b')
legend('First gene','Second gene');
xlabel('Ant num.');
ylabel('Individual Diversity index');

%全體多樣性指標，個體指標的平均/總和對比
GDI1=cumsum(DI1);
GDI2=cumsum(DI2);
for i=1:length(GDI1)      
    GDI1_avg(i)=GDI1(i)/i*50;
    GDI2_avg(i)=GDI2(i)/i*50;
end
figure, plot(2:(length(GDI1)+1),GDI1,'.r',2:(length(GDI2)+1),GDI2,'.b',2:(length(GDI1_avg)+1),GDI1_avg,'r',2:(length(GDI2_avg)+1),GDI2_avg,'b')
legend('Sum of first gene','Sum of second gene','Avg of first gene*50','Avg of second gene*50');
xlabel('Ant num.');
ylabel('Group Diversity index');
