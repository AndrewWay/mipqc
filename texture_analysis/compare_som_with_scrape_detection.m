%Run label_data.m prior to using this. 

for i=1:nObservations
    if(cell_classes(i,1)<0)
        i=nObservations;
    else
        mat = cell2mat(image_cells(i));
        [classified]=classify_som(mat,net,classifier,zmu,zsigma,som_dim1,som_dim2);
        if(classified-
    end
end
