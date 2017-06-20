clear all;clc;close all;warning off
Xi=[0,1,0,1; 
    0,0,1,1];
D=[0,1,1,0; % XOR
   0,1,1,1]; % OR
beta = 1;
[x,xs] = mapminmax(Xi);
[t,ts] = mapminmax(D);  
X1=[0.1; 
    0.9]
W1 =[1.9758    1.9771    1.8301
   -1.5929   -1.5953    1.3936
    0.7508    0.7494   -0.1607];
W2 =[3.4369    2.7578   -0.7844   -2.9030
    2.7636   -0.2826    0.9662    0.8718];
P = mapminmax('apply',X1,xs);
y = bp2value(P,W1,W2,beta);
O = mapminmax('reverse',y,ts)