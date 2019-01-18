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

box_length=40;
scratch_x=127;
scratch_y=81;
speckle_x=23;
speckle_y=86;


scratch=I(scratch_y:scratch_y+box_length,scratch_x:scratch_x+box_length);
speckle=I(speckle_y:speckle_y+box_length,speckle_x:speckle_x+box_length);

[scratch_ttd,scratch_truth,scratch_thres]=calc_ttd(scratch);
[speckle_ttd,speckle_truth,speckle_thres]=calc_ttd(speckle);

figure
s(1) = subplot(2,2,1);
plot(scratch_thres,scratch_truth)
ylabel('Scratch Truth')
xlabel('Threshold');
s(2) = subplot(2,2,2);
plot(speckle_thres,speckle_truth)
ylabel('Speckle Truth');
xlabel('Threshold');
s(3) = subplot(2,2,3);
imagesc(scratch)
s(4) = subplot(2,2,4);
imagesc(speckle)

fprintf("Scratch TTD: %f\n",scratch_ttd);
fprintf("Speckle TTD: %f\n",speckle_ttd);