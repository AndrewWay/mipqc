%Update classifier matrix by clicking on SOM map
if(~exist('classifier','var'))
    fprintf('classifier does not exist. Creating now\n');
    classifier=zeros(som_dim1,som_dim2);
end

tmp_map=createMapImage(image_cells,mapIndices,classifier);
imshow(tmp_map);
marker_size=8;
neuron_dim1 = size(tmp_map,1)/som_dim1;
neuron_dim2 = size(tmp_map,2)/som_dim2;
newlabel=0;

while(newlabel>=0)
coordinates_input = ginput(1);
row = round(coordinates_input(2));
column = round(coordinates_input(1));
%fprintf('You clicked on coordinates (row, column) = (%f, %f)\nWhich is the pixel in row %d, column %d\n', ...
%  coordinates_input(1), coordinates_input(2), row, column);

cell_i=floor(row/neuron_dim1)+1;
cell_j=floor(column/neuron_dim2)+1;

fprintf('Clicked on cell = (%f, %f)\n',cell_i,cell_j);
newlabel = input('Select class label: \n');
if(newlabel>=0)
    fprintf('Labelling neuron with class label: %d\n',newlabel);
    color = classLabelToColor(newlabel);
    %Add temporary coloring to the image
    start_row=row-marker_size;
    end_row =row+marker_size;
    start_column=column-marker_size;
    end_column=column+marker_size;
    tmp_map(start_row:end_row,start_column:end_column,1)=color(1);
    tmp_map(start_row:end_row,start_column:end_column,2)=color(2);
    tmp_map(start_row:end_row,start_column:end_column,3)=color(3);
    imshow(tmp_map);
    classifier(cell_i,cell_j)=newlabel; 
end

end