clear all;clc;close all;warning off;
folder = fullfile('./digits_data/');
listing = dir(folder);
lenlist=length(listing);
listend=listing(end).name;
imgvec=zeros(130,16*22);
if (~strcmp(listend,'..'))
    for i=3:lenlist
        filename=listing(i).name;
        indend = strfind(filename,'.png')-1;
        d=str2num(filename(7));
        n=str2num(filename(9:indend));
        img_ori=imread(strcat(folder,filename));
        img0=rgb2gray(img_ori)>200;
        img1=~img0;        
        s1=sum(img1,1); % 數字水平及垂直投影分割
        ind=find(s1>0);
        xmax=ind(end); xmin=ind(1);
        width=xmax-xmin;
        s2=sum(img1,2);
        ind=find(s2>0);
        ymax=ind(end); ymin=ind(1);
        height=ymax-ymin;
        rect=[xmin ymin width height];
        img2 = imcrop(img0, rect);
        img3=imresize(img2,[16,nan]);
        i2=size(img3,2);
        if i2<22
           img3(:,i2:22)=1; % 補1
           img4 = reshape(img3,1,[]); img5=~img4;
        else
           img4 = reshape(img3,1,[]); img5=~img4;
        end
        size_img5=size(img5);
        imgvec(d*13+n,:)=img5;        
    end
end
Xi=imgvec';
save Xi Xi
% figure, imshow(img_ori)
% figure, imshow(img2)
% figure, imshow(img3)
% 設計NN及其GA適應函數