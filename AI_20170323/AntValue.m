clear all; clc; close all
lb=[-5,-5];
ub=[5,5];
range=[lb;ub];
var_n=size(range,2); 
island=1;
popuSize=100;
bit_n=40;
popu=GA_initpopu(popuSize, bit_n, var_n);
c1=popu(1,:);
c2=popu(2,:);
g1=popu(1,1:bit_n);
g2=popu(1,(bit_n+1):(bit_n*2));
p1=popu(1,1);
p2=popu(1,2);


fcn='ObjFcn1';
in=c1;
[ chromosome_real ] = bin2real(in, bit_n, range);
[out,~] = feval(fcn, chromosome_real);

%適應函數score   -> 算出Z，越小越好
%成本函數|error| -> |(-無限大)-Z| = 誤差
%適應vs成本: 有相反的關係，一個遞增，一個遞減

%適應函數:計算每隻螞蟻的價值、分數、性能...
[PI1, c1_real] = GA_evaleachreal(c1, bit_n, range, fcn)
[PI2, c2_real] = GA_evaleachreal(c2, bit_n, range, fcn)