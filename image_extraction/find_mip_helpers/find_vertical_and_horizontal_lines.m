function [lines1,lines2] = find_vertical_and_horizontal_lines(I)
%FIND_VERTICAL_AND_HORIZONTAL_LINES Summary of this function goes here

if size(I,3)>1
    I = rgb2gray(I);
end

%Rescale the image if necessary. High resolution is not necessary and
%increases computation time.
scale_factor=1;

if size(I,2)>640
    scale_factor=size(I,2)/640;
    I = imresize(I, 640/size(I,2));
end


% Do edge detection using canny.
%try different thresholds (0.5thresh - 5 thresh) to get clean edges

%Students write your code here - use E as the name of edge image
otsu_thresh=graythresh(I);
E = edge(I,'canny',otsu_thresh);

%pause


% Do Hough transform to find lines.
[H,thetaValues,rhoValues] = hough(E);

% Extract peaks from the Hough array H. Parameters for this:
% houghThresh: Minimum value to be considered a peak. Default
% is 0.5*max(H(:))

%try different number of peaks and different thresholds

%TODO maybe. Find horizontal peaks, and then vertical peaks.
%Students write your code here
nPeaks = 50;%usually 10.
myThresh = 0.2*max(H(:));
peaks = houghpeaks(H,nPeaks,'Threshold',myThresh);

%Display Hough array and draw peaks on Hough array.
%      figure(11), imshow(H, []), title('Hough'),
%      xlabel('rho')
%      ylabel('theta'),impixelinfo;
%     for i=1:size(peaks,1)
%         rectangle('Position', ...
%         [peaks(i,2)-3, peaks(i,1)-3, ...
%         7, 7], 'EdgeColor', 'r');
%     end
%     pause
%
%     % Show all lines.
%     figure(10), imshow(E), title('All lines');
%     drawLines( ...
%     rhoValues(peaks(:,1)), ... % rhos for the lines
%     thetaValues(peaks(:,2)), ... % thetas for the lines
%     size(E), ... % size of image being displayed
%     'y'); % color of line to display
%     pause




% Find two sets of orthogonal lines.
[lines1, lines2] = find_orthogonal_lines( ...
    rhoValues(peaks(:,1)), ... % rhos for the lines
    thetaValues(peaks(:,2))); % thetas for the lines
%pause
if(isempty(lines1)||isempty(lines2))
   % disp("isempty");
else
   % disp("sorting");
    % Sort the lines, from top to bottom (for horizontal lines) and left to
    % right (for vertical lines).
    lines1 = sort_lines(lines1);
    lines2 = sort_lines(lines2);
    
    
    %Scale the Hough Lines
    lines1(2,:)=scale_factor*lines1(2,:);
    lines2(2,:)=scale_factor*lines2(2,:);

    
end
end

