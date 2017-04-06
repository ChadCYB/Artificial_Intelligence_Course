function [ Z,PI ] = ObjFcn2( chro )
P=chro(1); I=chro(2); D=chro(3);
u=0; dt=0.1;
for i=1:3
     x=(0.1 * (u^3) +0.3*(u^2)+0.5*u+0.0008)*(1e-10);
     e(i)=x-90;
     u=P*e(i)+D*(e(i)/dt)+I*sum(e);
     uu(i)=u;
end
z1=sum(abs(uu));
z2=sum(abs(e));
Z=[z1,z2];
PI=(1e+3)/(z1+z2);
end
   

