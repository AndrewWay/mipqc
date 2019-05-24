function [ mm ] = pixel_to_mm( pixels)
%PIXEL_TO_MM Summary of this function goes here
calibration_factor=153;% Number of pixels per millimeter

mm=pixels/calibration_factor;

end

