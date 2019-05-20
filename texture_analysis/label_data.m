if(exist('image_cells','var'))
    if(~exist('cell_classes','var'))
        fprintf('Cell_classes does not exist. Creating now\n');
        cell_classes = zeros(nObservations,1);
        for i=1:nObservations
            %Set all cell class labels to initially be -1 (no class)
           cell_classes(i,1)=-1; 
        end
    end
hold on;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
    for i=1:nObservations
        if(cell_classes(i,1)<0)
            mat = cell2mat(image_cells(i));
            figure(1),imshow(mat)
            fprintf('Enter class label for cell %d: \n',i);
            uinput = input('');
            if(uinput<-1)
               i=nObservations+1;
            else
                cell_classes(i,1)=uinput;
            end
        end
    end
hold off;    
end
