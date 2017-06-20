clear all; clc; close all; warning off;
load Xi
D=[];
for i=0:0.1:0.9
    D=[D,ones(1,13)*i];
end
Input_Num = size(Xi,1);
N = size(Xi,2);
Output_Num = 1;
Neuron_Hidden = 10;
Thr = -1 * ones(1,N);
X = [Xi;Thr]; %Training Set
Delta2=zeros(Output_Num, N);
Delta1=zeros(Neuron_Hidden, N);
wa=2.4*(0.5-rand(Neuron_Hidden, Input_Num+1));
dwa=zeros(Neuron_Hidden,Input_Num+1);
wb=2.4*(0.5-rand(Output_Num, Neuron_Hidden+1));
dwb=zeros(Output_Num, Neuron_Hidden+1);
count=0;
E=1;
mu=0.04;
a=0;
