function [ btd,cell_blob,thresholds  ] = calc_btd( img_cell )
%CALC_BTD Summary of this function goes here
%   Detailed explanation goes here

blob_cutoff=0.0001;
btd_start_blob=0.99;

max_thres_i=100;
max_thres=1;
min_thres=0;
dthres=(max_thres-min_thres)/max_thres_i;

cell_blob=zeros(max_thres_i,1);
thresholds=zeros(max_thres_i,1);

%Calculate blob for each of the thresholds
for i=1:max_thres_i
   thres = min_thres+dthres*i;
   thresholds(i,1)=thres;
   bw_img=im2bw(img_cell,thres);
   
   cell_blob(i,1)=blob(bw_img);
end

%Calculate the length of the curve between where blob<=0.99 and >= 0.0001
i=1;%int16((0.5-min_thres)/dthres);
%while(cell_blob(i,1)>btd_start_blob)
%    i=i+1;
%    
%end

blob_i=cell_blob(i,1);
thres_i=thresholds(i,1);
blob_ip1=cell_blob(i+1,1);
thres_ip1=thresholds(i+1,1);
btd=0;
%fprintf("----------------------------------------------\n");
%fprintf("Calculating btd starting at thres=%f\n",thres_i);
%fprintf("blob at this threshold: %f\n",blob_i);
while(blob_i>=blob_cutoff&&i<=max_thres_i)
    btd_seg=sqrt((blob_i-blob_ip1)^2+(thres_i-thres_ip1)^2);
    btd=btd+btd_seg;
    blob_i=blob_ip1;
    thres_i=thres_ip1;
    i=i+1;
    if(i+1<=max_thres_i)
        blob_ip1=cell_blob(i+1,1);
        thres_ip1=thresholds(i+1,1);
    end
end

end

