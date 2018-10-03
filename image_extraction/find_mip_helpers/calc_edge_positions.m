function [ coords ] = calc_edge_positions( bw_img)
%CALC_EDGE_POSITIONS stores the positions of all white pixels in bw_img
%In a 2D vector
n=size(bw_img,1);
m=size(bw_img,2);

coords=zeros(n*m,2);
index=1;

for i=1:n
    for j=1:m
        if(bw_img(i,j)==1)
            coords(index,:)=[j,i];
            index=index+1;
        end
    end
end
coords=coords(1:index-1,:);
end

