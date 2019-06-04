%Rescale the image if necessary. High resolution is not necessary and
%increases computation time.
clear all
close all


I = imread('data/D_raw/_MG_6884.png');
gray_I=rgb2gray(I);
otsu_thresh=graythresh(gray_I);
E = edge(gray_I,'canny',otsu_thresh);

qi=[2410;1593];
qip1=[2562;1985];

calc_cell_roughness(qi,qip1,E,I);