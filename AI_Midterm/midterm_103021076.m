function midterm_103021076()
    clear all;clc;close all;
    lb=[-13,-13];
    ub=[19,19];
    range =[lb;ub];
    var_n=size(range,2);

    popuSize=60;
    bit_n=50;
    generation=5000;
    popu=GA_initpopu(popuSize, bit_n, var_n);
    fcn='problemFcn';
    xover_rate=0.85;
    mutate_rate=0.003;
    for n_gen = 1:generation
        fitness=[];
        for i=1:size(popu,1)
           [fitness(i), ~] = GA_evaleachreal(popu(i,:), bit_n, range, fcn);
        end
        PI(n_gen)=max(fitness);
        [new_popu, elitism] = SelectionMutation(popu, bit_n, fitness,xover_rate, mutate_rate);
        popu=new_popu;
    end
    figure, plot(PI)
    c1=elitism(1,:);
    [PI1, c1_real] = GA_evaleachreal(c1, bit_n, range, fcn);
    value = PI1
    XY = c1_real
    result = c1_real(1).*sin(4.*c1_real(1))+1.1.*c1_real(2).*sin(2.*c1_real(2))
end

function [ Z,PI ] = problemFcn(chro)
    X=chro(1);
    Y=chro(2);
    Z=X.*sin(4.*X)+1.1.*Y.*sin(2.*Y);
    PI=(19*1+1.1*19*1)-Z;                % PI bigger is better
end

function popu=GA_initpopu(popuSize, bit_n, var_n)
    popu = rand(popuSize, bit_n*var_n) > 0.5; 
end

function [PI, chromosome_real] = GA_evaleachreal(chromosome, bit_n, range, fcn)
    [ chromosome_real ] = bin2real(chromosome,bit_n, range);
    [~,PI] = feval(fcn, chromosome_real); 
end

function [new_popu,elitism ] = SelectionMutation(popu, bit_len, fitness,xover_rate, mutate_rate)
    new_popu  = popu;
    popu_n    = size(popu, 1);
    bit_size  = size(popu, 2);
    var_n     = bit_size/bit_len;
    
    % ELITISM
    tmp_fitness = fitness;
    [~, index1] = max(tmp_fitness);	% find the best
    tmp_fitness(index1) = min(tmp_fitness);  
    [~, index2] = max(tmp_fitness);	% find the second best
    elitism=[popu(index1,:);popu(index2,:)];
    % Roulette wheel selection
    fitness2 = fitness/sum(fitness);	  % Roulette wheel selection
    pie(fitness2);
    cum_prob = cumsum(fitness2);          % Comparison table created
    
    % SELECTION and CROSSOVER
    for i = 1:popu_n/2   
        tmp = find(cum_prob - rand > 0); 
        parent1 = popu(tmp(1), :);       % parent1 for CROSSOVER
        tmp = find(cum_prob - rand > 0);
        parent2 = popu(tmp(1), :);       % parent2 for CROSSOVER

        if rand < xover_rate     
           xover_point = ceil(rand*(bit_len-1));        
           K=-bit_len;
           for J=1:var_n   % CROSSOVER FOR ALL PARAMETERS using J
             K=K+bit_len;  % CROSSOVER
             new_popu(i*2-1, (K+1):(K+bit_len)) = [parent1((K+1):(K+xover_point)), parent2((K+xover_point+1):(K+bit_len))];
             new_popu(i*2,   K+1:K+bit_len) = [parent2((K+1):(K+xover_point)), parent1((K+xover_point+1):(K+bit_len))];            
           end
        end
    end

    % MUTATION
    mask = (rand(popu_n, var_n*bit_len) < rand*mutate_rate);
    new_popu = xor(new_popu, mask); % TAKING MUTATION
    new_popu((end-1):end,:)=elitism;
end

function [ chromosome_real ] = bin2real(chromosome,bit_n, range)
    var_n  = length(chromosome)/bit_n;
    for i = 1:1:var_n
         tmp=GA_bit2num(chromosome(((i-1)*bit_n+1):(i*bit_n)),range(:,i));
         chromosome_real(i) = GA_round4dp(tmp);
    end

    function y=GA_round4dp(x)
        y=round(x*1000000)/1000000;
    end

    function num = GA_bit2num(bit, range)
        integer = polyval(bit, 2);       % bit to number
        num = integer*((range(2)-range(1))/(2^length(bit)-1))+range(1);
    end
end

