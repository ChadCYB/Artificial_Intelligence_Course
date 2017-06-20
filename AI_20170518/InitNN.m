clear all; clc; close all; warning off;
x = randn(3,1);
M=5;
m=2;
T=1;
[n,N] = size(x);
W1 = 0.1*randn(M,n+1)
W2 = 0.1*randn(m,M+1)
%m = size(W2,1);
%y = zeros(m,N);
for i = 1:N
    n1 = W1*[x(:,i)', 1]';
    a1 = tanh(T*n1);
    n2 = W2*[a1', 1]';
    a2 = tanh(T*n2);
    y(:,i) = a2;
end
