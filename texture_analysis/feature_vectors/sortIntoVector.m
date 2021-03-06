function [ O ] = sortIntoVector(M)
%SORTINTOVECTOR Sorts 2D matrix into ordered column vector
imageDim1 = size(M,1);
imageDim2 = size(M,2);

O = zeros(imageDim1*imageDim2,1);

index = 1;
for i=1:imageDim1
   for j=1:imageDim2
      O(index) = M(i,j);
      index=index+1;
   end
end
O = sort(O);

end

