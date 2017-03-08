clear all; clc; close all;
x=-5:0.03:5;
y=-5:0.03:5;
[X,Y]=meshgrid(x,y);
Z=fcn1(X,Y);
figure;
plot3(X,Y,Z,'r.','MarkerSize',1); hold on
ant=[0,0,fcn1(0,0)]; %???????????
h= plot3(ant(1),ant(2),ant(3),'b.','MarkerSize',18);
i=0;
title(['ant walk:', num2str(i), ' steps']);
%v=????? p=?????
v=inf; p=-inf;
for i=1:90 %????
    title(['ant walk:', num2str(i), ' steps']);
    antx=(rand(1,1)-0.5)*10; %ant??
    anty=(rand(1,1)-0.5)*10;
    antz=fcn1(antx,anty);
    if antz<v
        v=antz
    end
    if antz>p
        p=antz
    end
    set(h,'XData', antx);
    set(h,'YData', anty);
    set(h,'ZData', antz);
    drawnow
    pause(0.1); %??1sec
end