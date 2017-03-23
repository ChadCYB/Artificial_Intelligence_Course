function [ Z,PI ] = ObjFcn1( chro )
X=chro(1);
Y=chro(2);
%問題函數
Z=X.*sin(4.*X)+1.1.*Y.*sin(2.*Y);
%適應函數
PI=(5*1+1.1*5)-Z;

end

