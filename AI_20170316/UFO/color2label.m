function [ color_label ] = color2label( mean_a,mean_b,a,b )
a=double(a);
b=double(b);
nColors=length(mean_a);
for count=1:nColors
    distance(:,:,count)=((a-mean_a(count)).^2+...
                        (b-mean_b(count)).^2).^0.5;
end
[tmp, label] = min(distance,[],3);
color_label = repmat(label,[1 1 3]);