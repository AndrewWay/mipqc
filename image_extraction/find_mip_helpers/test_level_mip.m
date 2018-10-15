
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

draw_lines(lines11,lines22,I);


MIP=level_mip(I,lines11,lines22);
figure(1), imshow(I), title('Original');
figure(2), imshow(MIP), title('Rotated');

