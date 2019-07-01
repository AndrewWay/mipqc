%Run label_data.m prior to using this.
scrape_tPos=0;
scrape_tNeg=0;
scrape_fPos=0;
scrape_fNeg=0;

som_tPos=0;
som_tNeg=0;
som_fPos=0;
som_fNeg=0;

total_labeled_cells=0;
for i=1:nObservations
    if(cell_classes(i,1)<0)
        i=nObservations;
    else
        total_labeled_cells=total_labeled_cells+1;
        cell_index=random_cell_indices(1,i);
        human_label=cell_classes(i,1);
        im_cell=image_cells(cell_index);
        mat = cell2mat(im_cell);
        [som_label]=classify_som(im_cell,net,classifier,zmu,zsigma,som_dim1,som_dim2,nFeatures,tCoeff);
        [scrape_label]=find_scrapes(mat);
%         imshow(mat);
%         fprintf("Scrape: %d SOM: %d Human: %d\n",...
%             scrape_label,classified,human_label);
%         pause;
        

        if(human_label>0&&scrape_label>0)%scrape true positive
            scrape_tPos=scrape_tPos+1;
        elseif(human_label<=0&&scrape_label>0)%scrape false positive
            scrape_fPos=scrape_fPos+1;
        elseif(human_label>0&&scrape_label<=0)%scrape false negative
            scrape_fNeg=scrape_fNeg+1;
        elseif(human_label<=0&&scrape_label<=0)%scrape true negative
            scrape_tNeg=scrape_tNeg+1;
        end
        
        
        

        if(human_label>0&&som_label>0)%Som true positive
            som_tPos=som_tPos+1;
        elseif(human_label<=0&&som_label>0)%Som false positive
            som_fPos=som_fPos+1;
        elseif(human_label>0&&som_label<=0)%Som false negative
            som_fNeg=som_fNeg+1;
        elseif(human_label<=0&&som_label<=0)%Som true negative
            som_tNeg=som_tNeg+1;
        end
        
        
    end
end

scrape_tPos=scrape_tPos/total_labeled_cells;
scrape_tNeg=scrape_tNeg/total_labeled_cells;
scrape_fPos=scrape_fPos/total_labeled_cells;
scrape_fNeg=scrape_fNeg/total_labeled_cells;

som_tPos=som_tPos/total_labeled_cells;
som_tNeg=som_tNeg/total_labeled_cells;
som_fPos=som_fPos/total_labeled_cells;
som_fNeg=som_fNeg/total_labeled_cells;


fprintf("\tCorrect Defect\t Correct Non-Defect\t False Pos\t False Neg\t\n");
fprintf("Scrape: %15.2f %15.2f %15.2f %15.2f\n",scrape_tPos,scrape_tNeg,scrape_fPos,scrape_fNeg);
fprintf("SOM: %18.2f %15.2f %15.2f %15.2f\n",som_tPos,som_tNeg,som_fPos,som_fNeg);

