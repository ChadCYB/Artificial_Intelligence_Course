clear all; close all; clc
Xi = [0,1,0,1; %Training data
      0,0,1,1]
D = [ 0,1,1,0; %XOR
      0,1,1,1] %OR
[x,xs] = mapminmax(Xi);
[t,ts] = mapminmax(D);
mu = 0.02;
Neuron_Hidden = 3;
Ptrain = x;
Ttrain = t;
M = Neuron_Hidden;
[n,~] = size(Ptrain);
[m,N] = size(Ttrain);
alpha = mu; %learning rate
beta = 1; %slope of the tanh activation function
W1 = 0.1*randn(M, n+1);
W2 = 0.1*randn(m, M+1);
T = beta;

for i = 1:N
    n1 = W1*[Ptrain(:,i)', 1]';
    a1 = tanh(T*n1);
    n2 = W2*[a1', 1]';
    a2 = tanh(T*n2);
    s2 = diag(T*(1-a2.^2))*(Ttrain(:,i)-a2); %Backpropagation
    s1 = diag(T*(1-a1.^2))*W2(1:m,1:M)'*s2
    %update w & b
    W2 = W2-alpha*(-s2*[a1', 1]);           %dF/dW2
    W1 = W1-alpha*(-s1*[Ptrain(:,i)', 1]);  %dF/dW1
end

