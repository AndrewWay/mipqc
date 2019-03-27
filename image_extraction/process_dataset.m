clear all
close all




for k=6858:7008
    cr2FileName = strcat('data/D_raw/_MG_', num2str(k), '.CR2');
    outputFileName=strcat('data/D/D', num2str(k), '.png');
    fprintf("Checking if %s exists\n",cr2FileName);
    if exist(cr2FileName, 'file')
        if not(exist(outputFileName,'file'))
            fprintf("Processing MIP D%d\n",k);
            
            I0=imread(cr2FileName);
            I=I0(500:2684,1700:end,:);

            [MIP,marked_I]=extract_mip(I);
            if(MIP==0)
                continue;
            end
            
            %figure(1), imshow(I), title('Original Picture');
            %figure(2), imshow(MIP), title('Extracted MIP');
            
            subplot(1,2,1), imshow(marked_I), title('Original Picture');
            subplot(1,2,2), imshow(MIP),title('Extracted MIP');
            
           % user_entry = input('Save the extracted MIP? (y/n)\n','s');
           % close all;
           % if(strcmp('y',user_entry))
                fprintf("Saving file.\n");
                imwrite(MIP,outputFileName);
           % else
           %     fprintf("File not saved.\n");
           % end
        else
            fprintf("MIP %d has already been processed. Skipping.\n",k);
        end
    else
        fprintf("CR2 file does not exist\n");
    end
end