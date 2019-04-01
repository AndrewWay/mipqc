clear all
close all

font_size=100;

%Load the image
I0 = imread('data/B/MIP5.jpg');


%Make a down-scaled version of the image
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

%Scale the Hough Lines
lines11(2,:)=scale_factor*lines11(2,:);
lines22(2,:)=scale_factor*lines22(2,:);
lines11(1,:)=lines11(1,:);
lines22(1,:)=lines22(1,:);
I=I0;
[xInts,yInts] = find_intersections(lines11,lines22);

line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];
line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];
line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];
line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];


% I=insertText(I,[10 10],num2str(asp_rat,'Aspect ratio: %2.2f:1'),...
%     'FontSize',font_size,...
%     'BoxColor','black','TextColor','green');

hold on;

%Find and isolate the MIP edge
mip_edge = extract_mip_edge(lines11,lines22,mip_edge);
if(rescale)
    mip_edge_coords=floor(scale_factor*calc_edge_positions(mip_edge));
end
%Display the MIP edge in the image
for i=1:size(mip_edge_coords,1)
   x=mip_edge_coords(i,1);
   y=mip_edge_coords(i,2);
   
   I(y,x,1)=uint8(255);
   I(y,x,2)=uint8(0);
   I(y,x,3)=uint8(255);
   
end

imshow(I);

hold off;
%fprintf("Error: %d\n",err);