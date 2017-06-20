clear all;clc;close all;warning off;
%######### 2017-0504 #########
load Xi
D=[];
for i=0:0.1:0.9
   D=[D,ones(1,13)*i];
end
Input_Num = size(Xi,1);  % 輸入層數量
N = size(Xi,2);   % 訓練資料個數
Output_Num = 1;   % 輸出資料 Z
Neuron_Hidden = 10;
Thr = -1 * ones(1,N);  % Threshold  1*N
X = [Xi;Thr];% Training Set
Delta2=zeros( Output_Num, N);  % 輸出層的梯度初始設定
Delta1=zeros(Neuron_Hidden ,N);  % 隱藏層的梯度初始設定
wa=2.4*(0.5-rand(Neuron_Hidden,Input_Num+1)); % GA決定各層權重的初始值
dwa=zeros(Neuron_Hidden,Input_Num+1);
wb=2.4*(0.5-rand(Output_Num,Neuron_Hidden+1)); 
dwb = zeros (Output_Num , Neuron_Hidden+1);
count = 0; E = 1; %誤差平方值
mu = 0.04; % 學習率
a = 0;  % 慣性常數  (0 < a <1) a=0, 相當等於沒有慣性項
%Ay = 0.5; By = 0.6; % 隱藏層 y 的函數 Ay*tanh(By*v)
%Ao = 0.5; Bo = 0.3; % 輸出層 z 的函數 Az*tanh(Bz*v)


