clear all
close all


I0 = imread('test_image.jpg');

% Reduce image size; is faster and we don't need full size to find board.
if size(I0,2)>640
    I = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I=I0;
    rescale=0;
end


% Find the checkerboard. Return the four outer corners as a 4x2 array,
% in the form [ [x1,y1]; [x2,y2]; ... ].
MIP=extract_mip(I);

figure(1), imshow(I), title('Original Picture');
figure(2), imshow(MIP), title('Extracted MIP');