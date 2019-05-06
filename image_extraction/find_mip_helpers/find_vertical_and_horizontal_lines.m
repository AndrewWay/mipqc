function [lines1,lines2] = find_vertical_and_horizontal_lines(I)
%FIND_VERTICAL_AND_HORIZONTAL_LINES Summary of this function goes here
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
nPeaks = 10;
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
end

