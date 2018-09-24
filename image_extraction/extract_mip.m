function [ MIP ] = extract_mip( I0 )
%EXTRACT_MIP Returns the region of an image that contains a MIP

if size(I0,2)>640
    I = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I=I0;
    rescale=0;
end

[rotAng,px1,py1,px2,py2] = FindMIP(I);

if(rescale)
    px1=scale_factor*px1;
    px2=scale_factor*px2;
    py1=scale_factor*py1;
    py2=scale_factor*py2;
end

MIP=rotateAround(I0,0,0,-1*rotAng,'bilinear');
MIP=MIP(py1:py2,px1:px2,:);


end

