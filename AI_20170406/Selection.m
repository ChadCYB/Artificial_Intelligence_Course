function [new_popu,elitism ] = Selection(popu,bit_len,fitness,xover_rate)
new_popu = popu;            %由父母代產生子代的變數
popu_n   = size(popu, 1);   %父母代的數量
bit_long = size(popu, 2);   %染色體的長度
var_n    = bit_long/bit_len;%變數個體=染色體長度/基因長度

% ELITISM(菁英): find the best 2 & keep them in 
tmp_fitness = fitness;          % fitness:適應函數
[~, index1] = max(tmp_fitness);	% find the best
tmp_fitness(index1) = min(tmp_fitness); %將最大的改為最小的值，這樣才能找到第二大的
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
% 圓餅面積越大選中機率越高(繁衍下一代機率越大)

for i = 1:popu_n/2
    % === Select two parents based on their scaled fitness values
    tmp = find(cum_prob - rand > 0);    %pick up two parents for
    parent1 = popu(tmp(1), :);          %crossover
    tmp = find(cum_prob - rand > 0);
    parent2 = popu(tmp(1), :);
    % === Do Crossover
    if rand < xover_rate            % 0.8交配率(選中播種不一定能交配)
        xover_point = ceil(rand*(bit_len-1));
        K=-bit_len;
        for J=1:var_n               % Crossover for all parameters using J
            K=K+bit_len;            % Crossover now(進行交配)
            % save back first one
            new_popu(i*2-1, (K+1):(K+bit_len)) = [parent1((K+1):(K+xover_point)), parent2((K+xover_point+1):(K+bit_len))];
            % save back up to last
            new_popu(i*2, (K+1):(K+bit_len))   = [parent2((K+1):(K+xover_point)), parent1((K+xover_point+1):(K+bit_len))]; 
        end
    end
end

end
