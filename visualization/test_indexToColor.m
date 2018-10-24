d1=100;
d2=100;
I=zeros(d1,d2,3);

for i=1:d1
    for j=1:d2
        index=(i-1)*d2+j;
        rgb=indexToColor(index,d1,d2);
        I(i,j,:)=255*rgb;
    end
end
I=uint8(I);
imshow(I);
