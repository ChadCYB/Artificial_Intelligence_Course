function y = bp2val(P,W1,W2,beta)
    [n,N] = size(P);
    [m,M] = size(W2);
    y = zeros(m,N);
    for i = 1:N
        v1 = W1*[P(:,i)', 1]';
        xout1 = tanh(beta*v1);
        n2 = W2*[xout1', 1]';
        xout2 = tanh(beta*n2);
        y(:,i) = xout2;
    end

end