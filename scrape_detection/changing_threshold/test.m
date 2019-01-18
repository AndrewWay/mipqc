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



scratch_polygon=[145,92;
                 162,92;
                 145,110;
                 162,110;]
speckle_polygon=[27,98;
                 44,98;
                 27,116;
                 162,116;]
%I = insertShape(I,'Rectangle',[145,92,18,18]);
%I = insertShape(I,'Rectangle',[27,98,18,18]);


imshow(I)

box_length=40;
scratch_x=127;
scratch_y=81;
speckle_x=23;
speckle_y=86;

pause;
figure(1), imshow(BW);
figure(2), imshow(I);
pause;
scratch=I(scratch_y:scratch_y+box_length,scratch_x:scratch_x+box_length);
speckle=I(speckle_y:speckle_y+box_length,speckle_x:speckle_x+box_length);

figure(1), imshow(scratch);
figure(2), imshow(speckle);

max_thres_i=100;
max_thres=1;
min_thres=0;
dthres=(max_thres-min_thres)/max_thres_i;

scratch_truth=zeros(max_thres_i,1);
speckle_truth=zeros(max_thres_i,1);
thresholds=zeros(max_thres_i,1);
for i=1:max_thres_i
   thres = min_thres+dthres*i;
   threshold(i,1)=thres;
   bw_scratch=im2bw(scratch,thres);
   bw_speckle=im2bw(speckle,thres);
   
   scratch_truth(i,1)=truth(bw_scratch);
   speckle_truth(i,1)=truth(bw_speckle);
   
end

d1_scratch_truth=zeros(max_thres_i,1);
d1_speckle_truth=zeros(max_thres_i,1);

%Calculate numerical derivative for speckle truth and scratch truth


figure
s(1) = subplot(2,2,1);
plot(threshold,scratch_truth)
ylabel('Scratch Truth')
xlabel('Threshold');
s(2) = subplot(2,2,2);
plot(threshold,speckle_truth)
ylabel('Speckle Truth');
xlabel('Threshold');
s(3) = subplot(2,2,3);
imagesc(scratch)
s(4) = subplot(2,2,4);
imagesc(speckle)


