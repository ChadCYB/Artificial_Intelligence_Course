clear all; close all; clc
Xi = [0,1,0,1; %Training data
      0,0,1,1]
D = [ 0,1,1,0; %XOR
      0,1,1,1] %OR
[x,xs] = mapminmax(Xi);
[t,ts] = mapminmax(D);
%x
%t
%break

MaxN = 1e+5;
mu = 0.02;
Neuron_Hidden = 3;
Ptrain = x;
Trtrain = t;
Ptest = x;
Ttest = t;
M = Neuron_Hidden;
[n,~] = size(Ptrain);
[m,N] = size(Trtrain);
alpha = mu; %learning rate
MaxIter = MaxN; %maximum number of epochs
beta = 1; %slope of the tanh activation function
E = [];
iter = 0;
W1 = 0.1*randn(M, n+1);
W2 = 0.1*randn(m, M+1);

X1 = [1;
      1]
  P = mapminmax('apply',X1,xs);
  y = bp2val(P,W1,W2,beta);
  O = mapminmax('reverse',y,ts);
