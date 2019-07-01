
mip_defect_rate=[];
for k=6908:7008
    defect_rate=0;
    count=0;
    inputFileName=strcat('data/D/D', num2str(k), '.png');
    fprintf("Checking if %s exists\n",inputFileName);
    if exist(inputFileName, 'file')
        MIP=imread(inputFileName);
        imageDim1 = size(MIP,1);
        imageDim2 = size(MIP,2);
        
        index=1;
        new_cells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
        
        
        %Find BMU
        y1=1;
        for i=1:img_dim1Divisions
            x1=1;
            for j=1:img_dim2Divisions
                count=count+1;
                img_ij=cell2mat(new_cells(i,j));
                
                dim1_ij=size(img_ij,1);
                dim2_ij=size(img_ij,2);
                
                cell_center_x=x1+dim2_ij/2;
                cell_center_y=y1+dim1_ij/2;
                
                featVec = create_feature_vector(img_ij,nFeatures);
                %MUST ZSCORE THIS DATA TO MATCH ZDATA (refer to loadData.m)
                featVec=(featVec-zmu)./zsigma;
                featVec = featVec*tCoeff;
                clusterIndex=vec2ind(net(featVec'));
                [in,jn]=ind2sub([som_dim1,som_dim2],clusterIndex);
                

                if(classifier(in,jn)>0&&inpolygon(cell_center_x,cell_center_y,...
                        rectangle_xInts,rectangle_yInts))
%                     rectangle('Position',[x1,y1,dim2_ij,dim1_ij],...
%                         'Curvature',[0,0],...
%                         'EdgeColor', 'r',...%classLabelToColor(classifier(in,jn))/255,...
%                         'LineWidth', 1,...
%                         'LineStyle','-')
                    defect_rate=defect_rate+1;
                end
                
                x1=x1+dim2_ij;
                index=index+1;
            end
            y1=y1+dim1_ij;
        end
        mip_defect_rate=[mip_defect_rate;defect_rate/count];
    else
        fprintf("CR2 file does not exist\n");
    end
end
