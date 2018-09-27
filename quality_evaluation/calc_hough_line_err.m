function [ err ] = calc_hough_line_err( edge,line1,line2,line3,line4)
%FITERROR Summary of this function goes here
%   Detailed explanation goes here

nEdgePoints = size(edge,1);
err=0;
q=zeros(2,1);
%For each point in the edge
for p=1:nEdgePoints
    q(1,1) = edge(p,1);
    q(2,1) = edge(p,2);
    %Calculate its orthogonal distance from the current point to each line
    d1=distance(line1(:,1),line1(:,2),q);
    d2=distance(line2(:,1),line2(:,2),q);
    d3=distance(line3(:,1),line3(:,2),q);
    d4=distance(line4(:,1),line4(:,2),q);
    
    distances = [d1;d2;d3;d4];
    [M,I] = min(distances);
    
    %For the projection vector that is the smallest of these four,
    %the point belongs to the corresponding side.
    
    %Add the projection distance to the error
    err=err+abs(M);
    
end
end