function [PI, chromosome_real] = GA_evaleachreal(chromosome, bit_n, range, fcn)
    [ chromosome_real ] = bin2real(chromosome, bit_n, range);
    [~,PI] = feval(fcn, chromosome_real);
end