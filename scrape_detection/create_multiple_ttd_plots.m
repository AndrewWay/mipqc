numOfImages=size(image_cells,1);

rng(0,'twister');
a = 1;
b = numOfImages;
r = round((b-a).*rand(1000,1) + a);
n=14400;
hold on;
for i=1:n

    %get the ith cell
    img_cell=image_cells(i,1);
    img=cell2mat(img_cell);
    %Calculate the TTD for this cell
    [ttd,truths,thresholds]=calc_ttd(img);
    %Store the result
    %figure(1),subplot(4,5,i);
    figure(1),plot(thresholds,truths)
end
hold off;
