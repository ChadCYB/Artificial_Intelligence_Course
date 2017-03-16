clear all; clc; close all
load snapshot1
load mean_a_YRGBW
load mean_b_YRGBW
cform = makecform('srgb2lab');
figure(1),
idyrgb1; %init UFO
[c,r] = ginput(1);
Target(1,:)=[c,r]; %target
plot(Target(1,1),Target(1,2),'co','MarkerSize',12)

lb=[-30,-30,-30,-30,-30,-30,-30,-30];
ub=[30,30,30,30,30,30,30,30];
range=[lb;ub];
var_n=size(range,2); 
island=1;
popuSize=100;
bit_n=50;

while(1)
    popu=GA_initpopu(popuSize, bit_n, var_n);
    %fitness=[];
    chromosome_real=[];
    for i=1:size(popu,1);
        [PI,chromosome_real(i,:)] = GA_real(popu(i,:), bit_n, range);
    end
    break
end
chromesome_real = ceil(chromosome_real)
