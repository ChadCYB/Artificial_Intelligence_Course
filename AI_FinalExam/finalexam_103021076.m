clear all; close all; clc
Xi = [1, 1, 1; %Training data
     -1, 1, 1;
     -1,-1, 1]
D = [ 0,0,1;
      1,0,0]

[x,xs] = mapminmax(Xi);
[t,ts] = mapminmax(D);
MaxN = 1e+5;
mu = 0.02;  %learning rate
Neuron_Hidden = 4;
Ptrain = x;
Ttrain = t;
Ptest = x;
Ttest = t;
M = Neuron_Hidden;
[n,~] = size(Ptrain);
[m,N] = size(Ttrain);
alpha = mu;         %learning rate
MaxIter = MaxN;     %maximum number of epochs
beta = 1;           %slope of the tanh activation function
E = [];
iter = 0;
%W1 - weights from the input to the hidden layer (includes biases)
W1 = 0.1*randn(M, n+1);
%W2 - weights from the hidden layer to the output (includes biases)
W2 = 0.1*randn(m, M+1);

while (iter < MaxIter)
    iter = iter+1;
    for i = 1:N
        v1 = W1*[Ptrain(:,i)', 1]';
        xout1 = tanh(beta*v1);
        g1 = beta*(1-xout1.^2);
        v2 = W2*[xout1', 1]';
        xout2 = tanh(beta*v2);
        g2 = beta*(1-xout2.^2);
        D2 = diag(g2)*(Ttrain(:,i)-xout2);
        D1 = diag(g1)*W2(1:m,1:M)'*D2;
        %update w & b
        W2 = W2+alpha*D2*[xout1', 1];        %dF/dW2
        W1 = W1+alpha*D1*[Ptrain(:,i)', 1];  %dF/dW1
    end
    MSEnew = norm(Ttest-bp2value(Ptest,W1,W2,beta));
    E = [E; MSEnew];
end
W1
W2
figure, plot(E)
X1=[1;
   -1;
   -1]
P = mapminmax('apply',X1,xs);
y = bp2value(P,W1,W2,beta);
O = mapminmax('reverse',y,ts)
    

