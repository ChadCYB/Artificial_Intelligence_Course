clear all; close all; clc

x=-5:0.01:5;
[y] = FermiFcn(x);

figure, plot(x,y,'b'); grid on;
xlabel('x');
ylabel('y=f(x)');
hold on

T=0.5;
[y] = FermiFcnT(x,T);
plot(x,y,'c');

[y] = HyperFcn(x);
plot(x,y,'r');

[y] = HeavFcn(x);
plot(x,y,'r');