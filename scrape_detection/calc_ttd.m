function [ ttd,cell_truth,thresholds ] = calc_ttd( img_cell )
%CALC_TTD Calculates Truth Transition Distance for an image cell

truth_cutoff=0.0001;
ttd_start_truth=0.99;

max_thres_i=100;
max_thres=1;
min_thres=0;
dthres=(max_thres-min_thres)/max_thres_i;

ttd=0;
cell_truth=zeros(max_thres_i,1);
thresholds=zeros(max_thres_i,1);

%Calculate truth for each of the thresholds
for i=1:max_thres_i
   thres = min_thres+dthres*i;
   thresholds(i,1)=thres;
   bw_img=im2bw(img_cell,thres);
   
   cell_truth(i,1)=truth(bw_img);
end

%Calculate the length of the curve between where truth<=0.99 and >= 0.0001
i=1;%int16((0.5-min_thres)/dthres);
%while(cell_truth(i,1)>ttd_start_truth)
%    i=i+1;
%    
%end

thres=min_thres+dthres*i;

truth_i=cell_truth(i,1);
thres_i=thresholds(i,1);
truth_ip1=cell_truth(i+1,1);
thres_ip1=thresholds(i+1,1);
ttd=0;
%fprintf("----------------------------------------------\n");
%fprintf("Calculating TTD starting at thres=%f\n",thres_i);
%fprintf("Truth at this threshold: %f\n",truth_i);
while(truth_i>=truth_cutoff&&i<=max_thres_i)
    ttd_seg=sqrt((truth_i-truth_ip1)^2+(thres_i-thres_ip1)^2);
    ttd=ttd+ttd_seg;
    truth_i=truth_ip1;
    thres_i=thres_ip1;
    i=i+1;
    if(i+1<=max_thres_i)
        truth_ip1=cell_truth(i+1,1);
        thres_ip1=thresholds(i+1,1);
    end
end
%fprintf("TTD ended at thres=%f\n",thres_i);
%fprintf("i-1 truth: %f\n",cell_truth(i-1,1));
end

