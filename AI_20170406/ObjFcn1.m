function [ Z,PI ] = ObjFcn1( chro )
X=chro(1);
Y=chro(2);

Z=X.*sin(4.*X)+1.1.*Y.*sin(2.*Y);
PI=(5*1+1.1*5)-Z;

end