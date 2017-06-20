function AntSol()
    clear all;clc;close all;warning off;
    lb=[-13,-13];%兩組基因的蛋白質範圍的最小值
    ub=[19,19];%兩組基因的蛋白質範圍的最大值
    range =[lb;ub];
    var_n=size(range,2);
    island=1;%一個島
    popuSize=60; %人口(染色體)/每島
    bit_n=50;%一組基因的長度，等位基因alleles，所以每組基因長度皆相同
    popu=GA_initpopu(popuSize, bit_n, var_n);%螞蟻(產生族群)
    fcn='ObjFcn1a';
    xover_rate=0.8;
    mutate_rate=0.002;
    for n_gen = 1:1e5
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
    [PI1, c1_real] = GA_evaleachreal(c1, bit_n, range, fcn) %c1_real是解(答案) 
end

function [new_popu,elitism ] = SelectionMutation(popu, bit_len, fitness,xover_rate, mutate_rate)
    new_popu  = popu;%由父母代產生子代的變數
    popu_n    = size(popu, 1);%父母代的數量
    bit_long  = size(popu, 2);%染色體長度
    var_n     = bit_long/bit_len;%變數個數=染色體長度/基因長度
    % ELITISM(菁英): find the best 2 & keep them in 
    tmp_fitness = fitness;
    [~, index1] = max(tmp_fitness);	% find the best
    tmp_fitness(index1) = min(tmp_fitness);  
    [~, index2] = max(tmp_fitness);	% find the second best
    popu1=popu(index1,:);
    popu2=popu(index2,:);
    elitism=[popu1;popu2];
    % Roulette wheel selection(用俄羅斯輪盤來選擇)
    xfitness = fitness/sum(fitness);	  % Roulette wheel selection
    %pie(xfitness);
    cum_prob = cumsum(xfitness);          % Comparison table created    
    % SELECTION and CROSSOVER
    for i = 1:popu_n/2   
        % === Select two parents based on their scaled fitness values
        tmp = find(cum_prob - rand > 0); % PICK UP TWO PARENTS FOR
        parent1 = popu(tmp(1), :);       % CROSSOVER(準備交配)
        tmp = find(cum_prob - rand > 0);
        parent2 = popu(tmp(1), :);
        % === Do crossover
        if rand < xover_rate,   %0.8左右     
           xover_point = ceil(rand*(bit_len-1));        
           K=-bit_len;
           for J=1:var_n   % CROSSOVER FOR ALL PARAMETERS using J
             K=K+bit_len;  % CROSSOVER NOW(進行交配)
             new_popu(i*2-1, (K+1):(K+bit_len)) = [parent1((K+1):(K+xover_point)), parent2((K+xover_point+1):(K+bit_len))];
             new_popu(i*2,   K+1:K+bit_len) = [parent2((K+1):(K+xover_point)), parent1((K+xover_point+1):(K+bit_len))];            
           end
        end
    end
    %new_popu是交配後所得的子代，子代數量與父母代數量相同
    % MUTATION
    mask = (rand(popu_n, var_n*bit_len) < rand*mutate_rate);
    new_popu = xor(new_popu, mask); % TAKING MUTATION
    new_popu((end-1):end,:)=elitism;
end

function popu=GA_initpopu(popuSize, bit_n, var_n)
    popu = rand(popuSize, bit_n*var_n) > 0.5; 
end


function [PI, chromosome_real] = GA_evaleachreal(chromosome, bit_n, range, fcn)
    [ chromosome_real ] = bin2real(chromosome,bit_n, range);
    [~,PI] = feval(fcn, chromosome_real);   % 呼叫函數fcn   
end

function [ chromosome_real ] = bin2real(chromosome,bit_n, range)
    var_n  = length(chromosome)/bit_n;
    for i = 1:1:var_n
         tmp=GA_bit2num(chromosome(((i-1)*bit_n+1):(i*bit_n)),range(:,i));
         chromosome_real(i) = GA_round4dp(tmp); % 二進位轉換成十進位

    end


    function y=GA_round4dp(x)
        y=round(x*1000000)/1000000;
    end

    function num = GA_bit2num(bit, range)
        integer = polyval(bit, 2);  %[1 1 0 1]==> 1*(2^3)+1*(2^2)+0*(2^1)+1*(2^0)
        num = integer*((range(2)-range(1))/(2^length(bit)-1))+range(1);
    end

end

function [ Z,PI ] = ObjFcn1a(chro)
    X=chro(1);
    Y=chro(2);
    Z=X.*sin(4.*X)+1.1.*Y.*sin(2.*Y);
    PI=(19*1+1.1*19*1)-Z;%最大化PI就是最小化Z，那找到山谷(因為是最小化Z)就是你的期望
end