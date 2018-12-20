allMapIndices=[];
allRegionCells=[];


som=cell2mat(net.IW);

for k=1:numOfImages
    pngFileName = strcat('data/B/MIP', num2str(k), '.jpg');
    if exist(pngFileName, 'file')
        %Read into MIP image to matrices
        I = imread(pngFileName);
        
        [MIP]=extract_mip(I);
        
        regionCells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
        
        mapIndices = zeros(2,som_dim2,som_dim3);
        index=1;
        
        %Dice the matrix into regions
        uData=createFeatVecs(MIP,nFeats,img_dim1Divisions,img_dim2Divisions);
        uData=uData*tCoeff;%Transform unknown data
        
        %Find BMU
        for i=1:img_dim1Divisions
            for j=1:img_dim2Divisions
                
                featVec = uData(index,:)';
                %clusterIndex=findBMU(featVec,som);
                clusterIndex=vec2ind(net(featVec));
                
                BMU_i=floor(clusterIndex/som_dim2)+1;
                BMU_j=mod(clusterIndex,som_dim3)+1;
                
                mapIndices(1,i,j)=BMU_i;
                mapIndices(2,i,j)=BMU_j;
                index=index+1;
            end
        end
    end
end
createMapImage(regionCells,mapIndices);