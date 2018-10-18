clear all
close all

%Load the image
I0 = imread('mip_transmitted.jpg');
I0=I0(:,1418:4166,:);
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


stats = regionprops('table',BW2,'Centroid',...
    'MajorAxisLength','MinorAxisLength')

centroids = cat(1, stats.Centroid);
imshow(BW2)
hold on
plot(centroids(:,1), centroids(:,2), 'b*')
hold off


