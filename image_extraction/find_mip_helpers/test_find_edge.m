clear all
close all


I0 = imread('test_image2.jpg');

if size(I0,2)>640
    I = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I=I0;
    rescale=0;
end

%Retrieve the sets of lines enclosing the MIP in image I
[lines11,lines22,mip_edge] = find_mip(I);

imshow(mip_edge);
pause;
mip_edge = extract_mip_edge(lines11,lines22,mip_edge);
imshow(mip_edge);
pause;

mip_edge_coords = calc_edge_positions(mip_edge);

if(rescale)
   mip_edge_coords=floor(scale_factor*mip_edge_coords); 
end

px_d=5;

for i=1:size(mip_edge_coords,1)
   x=mip_edge_coords(i,1);
   y=mip_edge_coords(i,2);
   
   I0(y-px_d:y+px_d,x-px_d:x+px_d,1)=uint8(0);
   I0(y-px_d:y+px_d,x-px_d:x+px_d,2)=uint8(255);
   I0(y-px_d:y+px_d,x-px_d:x+px_d,3)=uint8(0);
   
end

imshow(I0);