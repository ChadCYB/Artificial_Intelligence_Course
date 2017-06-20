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
    
    popu1 = popu(index1,:);
    popu2 = popu(index2,:);
    elitism=[popu1;popu2];
    xfitness = fitness/sum(fitness);	  % Roulette wheel selection
    cum_prob = cumsum(xfitness);          % Comparison table created
    
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