function [ chromosome_real ] = bin2real(chromosome, bit_n, range)
var_n = length(chromosome)/bit_n;
for i = 1:var_n
    tmp = GA_bit2num(chromosome(((i-1)*bit_n+1):(i*bit_n)), range(:,i)); %Binary to Decimal
    chromosome_real(i) = GA_round4dp(tmp);
end
end

function [ PI, chromosome_real ] = GA_evalreal(chromosome, bit_n, range, fcn)
    chromosome_real = bin2real(chromosome, bit_n, range);
    PI = feval(fcn, chromosome_real);
end

function y=GA_round4dp(x)
    y=round(x*1000000)/1000000;
end

function num = GA_bit2num(bit, range)
    integer = polyval(bit,2);   %[1 1 0 1] ==> 1*(2^3) + 1*(2^2) + 0*(2^1) + 1*(2^0)
    num = integer*((range(2)-range(1))/(2^length(bit)-1))+range(1);
end