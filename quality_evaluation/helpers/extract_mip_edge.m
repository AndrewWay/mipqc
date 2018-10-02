function [ K ] = extract_mip_edge(lines11,lines22, bw_img )
%EXTRACT_MIP_EDGE Extracts edge that best fits hough lines
%   Detailed explanation goes here

%Find the connected chains of 1s
s = regionprops(bw_img,'PixelIdxList');
L = bwlabel(bw_img);
d = cellfun('length',{s(:).PixelIdxList}); %total number of pixels in each region
[~,order] = sort(d,'descend');

[xInts,yInts] = find_intersections(lines11,lines22);

line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];
line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];
line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];
line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];

min_err=inf;
best_mip_edge_index=0;
for i=1:size(s,1)
    K = ismember(L,order(i)); %only show the top 10 edges
    coords = calc_edge_positions(K);
    err=calc_hough_line_err(coords,line1,line2,line3,line4)/d(order(i));
    if(err<min_err)
        best_mip_edge_index=i;
        min_err=err;
    end
end
K=ismember(L,order(best_mip_edge_index));
end

