clear all;clc;close all;
lb=[-10,-10];
ub=[10,10];
range =[lb;ub];
var_n=size(range,2);
fcn = 'ObjFcn1'
popuSize=60;
bit_n=50;
generation=5000;
popu=GA_initpopu(popuSize, bit_n, var_n);
xover_rate=0.85;
mutate_rate=0.001;
gen_no=50;

for n_gen = 1:gen_no
    for i=1:size(popu,1)
       [fitness(i), ~] = GA_evaleachreal(popu(i,:), bit_n, range, fcn);
    end
    PI(n_gen)=max(fitness);
        [new_popu, elitism] = SelectionMutation(popu, bit_n, fitness,xover_rate, mutate_rate);
    popu=new_popu;
    
end
c1=elitism(1,:);
[PI1, c1_real] = GA_evaleachreal(c1, bit_n, range, fcn);
figure, plot(PI)