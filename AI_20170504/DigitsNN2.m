clear all;clc;close all;warning off;
%######### 2017-0504 #########
load Xi
D=[];
for i=0:0.1:0.9
   D=[D,ones(1,13)*i];
end
Input_Num = size(Xi,1);  % ��J�h�ƶq
N = size(Xi,2);   % �V�m��ƭӼ�
Output_Num = 1;   % ��X��� Z
Neuron_Hidden = 10;
Thr = -1 * ones(1,N);  % Threshold  1*N
X = [Xi;Thr];% Training Set
Delta2=zeros( Output_Num, N);  % ��X�h����ת�l�]�w
Delta1=zeros(Neuron_Hidden ,N);  % ���üh����ת�l�]�w
wa=2.4*(0.5-rand(Neuron_Hidden,Input_Num+1)); % GA�M�w�U�h�v������l��
dwa=zeros(Neuron_Hidden,Input_Num+1);
wb=2.4*(0.5-rand(Output_Num,Neuron_Hidden+1)); 
dwb = zeros (Output_Num , Neuron_Hidden+1);
count = 0; E = 1; %�~�t�����
mu = 0.04; % �ǲ߲v
a = 0;  % �D�ʱ`��  (0 < a <1) a=0, �۷���S���D�ʶ�
%Ay = 0.5; By = 0.6; % ���üh y ����� Ay*tanh(By*v)
%Ao = 0.5; Bo = 0.3; % ��X�h z ����� Az*tanh(Bz*v)


