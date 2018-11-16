clear all
close all

%Load the image
I0 = imread('mip_transmitted.jpg');
I0 = imread('../Surface Defect Detection/defectdetect/MIPs/MIP5.jpg');
%I0=I0(:,1418:4166,:);
%Make a down-scaled version of the image
if size(I0,2)>640
    I = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I=I0;
    rescale=0;
end

otsu_thres=graythresh(I);
I=extract_mip(I);

G=rgb2gray(I);


BW=im2bw(I,otsu_thres);
BW2 = bwareaopen(BW, 20);
%figure(1), imshow(BW);
%figure(2), imshow(histogram(G));


stats = regionprops('table',BW,'Centroid',...
    'MajorAxisLength','MinorAxisLength')

centroids = cat(1, stats.Centroid);
imshow(BW)
hold on
plot(centroids(:,1), centroids(:,2), 'O')
hold off



% 
% areas=regionprops(BW, 'Area');
% areas=cat(1,areas.Area);
% figure(1), histogram(areas,150);
% figure(2),imshow(BW);


% map = brewermap(5,'Set1'); 
% 
% figure
% histf(H1,-1.3:.01:1.3,'facecolor',map(1,:),'facealpha',.5,'edgecolor','none')
% hold on
% histf(H2,-1.3:.01:1.3,'facecolor',map(2,:),'facealpha',.5,'edgecolor','none')
% histf(H3,-1.3:.01:1.3,'facecolor',map(3,:),'facealpha',.5,'edgecolor','none')
% box off
% axis tight
% legalpha('H1','H2','H3','location','northwest')
% legend boxoff
