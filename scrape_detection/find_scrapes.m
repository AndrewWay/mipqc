function [ defected ] = find_scrapes( im )
%FIND_SCRAPES Determines presence of scrapes
threshold=0.75;
truth_threshold=0.005;

im_truth=truth(im,threshold);

if(im_truth>=truth_threshold)
    defected=1;
else
    defected=0;
end
end

