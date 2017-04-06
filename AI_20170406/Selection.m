function [new_popu,elitism ] = Selection(popu,bit_len,fitness,xover_rate)
new_popu = popu;            %???????????
popu_n   = size(popu, 1);   %??????
bit_long = size(popu, 2);   %??????
var_n    = bit_long/bit_len;%????=?????/????

% ELITISM(??): find the best 2 & keep them in 
tmp_fitness = fitness;          % fitness:????
[~, index1] = max(tmp_fitness);	% find the best
tmp_fitness(index1) = min(tmp_fitness); %?????????????????????
[~, index2] = max(tmp_fitness);	% find the second best
popu1=popu(index1,:);           % The best gene
popu2=popu(index2,:);           % Second best gene
elitism=[popu1;popu2];

% Roulette wheel selection
xfitness = fitness/sum(fitness);	% Roulette wheel selection
pie(xfitness);
cum_prob = cumsum(xfitness);        % Comparison table created
figure, plot(cum_prob);

xlabel('Ant No.');
ylabel('From first ant to last ant');
title('Ant fitness pie chart')
% ????????????(?????????)

for i = 1:popu_n/2
    % === Select two parents based on their scaled fitness values
    tmp = find(cum_prob - rand > 0);    %pick up two parents for
    parent1 = popu(tmp(1), :);          %crossover
    tmp = find(cum_prob - rand > 0);
    parent2 = popu(tmp(1), :);
    % === Do Crossover
    if rand < xover_rate            % 0.8???(??????????)
        xover_point = ceil(rand*(bit_len-1));
        K=-bit_len;
        for J=1:var_n               % Crossover for all parameters using J
            K=K+bit_len;            % Crossover now(????)
            % save back first one
            new_popu(i*2-1, (K+1):(K+bit_len)) = [parent1((K+1):(K+xover_point)), parent2((K+xover_point+1):(K+bit_len))];
            % save back up to last
            new_popu(i*2, (K+1):(K+bit_len))   = [parent2((K+1):(K+xover_point)), parent1((K+xover_point+1):(K+bit_len))]; 
        end
    end
end

end