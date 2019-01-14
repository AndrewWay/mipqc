%Rescale the image if necessary. High resolution is not necessary and
%increases computation time.
clear all
close all


min_grade=0.7;
max_grade=1-min_grade;

I0 = imread('data/B/MIP7.jpg');
if size(I0,2)>640
    I0 = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I0=I0;
    rescale=0;
end
%Retrieve the sets of lines enclosing the MIP in image I
[lines11,lines22,mip_edge] = find_mip(I0);
%lines11: mostly vertical
%lines22: mostly horizontal

area = calc_surface_area(lines11,lines22);


