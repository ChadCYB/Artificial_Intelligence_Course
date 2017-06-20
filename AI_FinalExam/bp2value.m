function y = bp2value(P,W1,W2,beta)
%
% BP2VAL - output of the MLP NN with one hidden layer
%
%  y = bp2val(P,W1,W2,beta);
%
%	P		   - n by N matrix containing N, n-dimensional input vectors
%	W1			- weigths from the input to the hidden layer (icludes biases)
%	W2			- weigths from the hidden layer to the output (includes biases)
%	beta		- slope of the activation function
%	y			- m by N matrix containing N, m-dimesional output vectors

[n,N] = size(P);
[m,M] = size(W2);
y = zeros(m,N);
for i = 1:N
  v1 = W1*[P(:,i)' 1]';
  xout1 = tanh(beta*v1);
  v2 = W2*[xout1' 1]';
  xout2 = tanh(beta*v2);
  y(:,i) = xout2;
end

