clear all;
close all;
L=256;

%I = imread('gradient_mip.jpg');
I = imread('original_mip.jpg');

G=rgb2gray(I);
imshow(I);

[counts] = histogram(G,256);
p=counts.Values;

%set(gca,'YScale','log')
T = graythresh(G);
variances=zeros(1,L);
for i=1:L
    variances(i)=sigb(i,p,L);
end


function [res] =  sigb(t,p,L)
    [w0,w1] = om(t,p,L);
    [mu0,mu1] = mu(t,p,L);
    res=w0*w1*(mu0-mu1)^2;
    
end
function [ mu0,mu1 ] = mu(t,p,L)
    mu0=0;
    mu1=0;
    
    [w0,w1] = om(t,p);
    
    for i=1:t
        mu0=mu0+i*p(i);
    end
    mu0=mu0/w0;
    
    for i=t+1:L
        mu1=mu1+i*p(i);
    end
    mu1=mu1/w1;
        
end


function [ w0,w1 ] = om(t,p,L)
    w0=0;
    w1=0;
    for i=1:t
        w0=w0+p(i);
    end
    for i=t+1:L
        w1=w1+p(i);
    end
end


function [res] = muT(p,L)
res=0;    
    for i=1:L
       res=res+i*p(i); 
    end
end