rgb=snapshot1;
imshow(rgb); hold on
Lab=applycform(rgb,cform);
a=Lab(:,:,2); b=Lab(:,:,3);
color_label=color2label(mean_a,mean_b,a,b);

for count=1:4
    color=rgb; bw=zeros(size(color,1),size(color,2));
    color(color_label ~= count)=0;
    bw(:,:)=color(:,:,1)+color(:,:,2)+color(:,:,3);
    bw(bw>0)=1;
    bw = bwareaopen(bw,30);
    se = strel('disk',2);
    bw = imclose(bw,se);
    bw = imfill(bw, 'holes');
    [B,L] = bwboundaries(bw,'noholes');
    stats = regionprops(L,'Area','Centroid');
    for k = 1:length(B)
        area = stats(k).Area;
        if area>5000
            boundary = B{k};
            plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
            cen_xy(count,:) = stats(k).Centroid;
            plot(cen_xy(count,1),cen_xy(count,2),'r+','MarkerSize',5)
            switch count
                case 1
                    cxy_string = sprintf('Y(%3.0f, %3.0f)', cen_xy(count,:));
                case 2
                    cxy_string = sprintf('R(%3.0f, %3.0f)', cen_xy(count,:));
                case 3
                    cxy_string = sprintf('G(%3.0f, %3.0f)', cen_xy(count,:));
                case 4
                    cxy_string = sprintf('B(%3.0f, %3.0f)', cen_xy(count,:));
            end
            text(boundary(1,2)-65,boundary(1,1)+13,cxy_string,'Color','b','FontSize',6,'FontWeight','bold')
        end
    end
end