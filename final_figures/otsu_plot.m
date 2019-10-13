clear all;
close all;
L=256;

I = imread('gradient_mip.jpg');
%I = imread('D:/MSC FINAL DATA/_MG_6877.CR2');

%     I=remove_ruler(I);
%     I = I(:,2000:end,:); 
%     if size(I,2)>640
%     scale_factor=size(I,2)/640;
%     I = imresize(I, 640/size(I,2));
% end
%G=rgb2gray(I);
G=I;
%imshow(I);

[counts] = histogram(G,L);
%hist(double(G(:)),L);
yyaxis left
ylabel('Log(Pixel Count)');
xlabel('Pixel Intensity');
set(gca,'YScale','log')


%hist(double(G(:)),256)
p=counts.Values;

hold on;


T = graythresh(G);
[T,sigma_b_squared] = otsuthresh(p);
variances=zeros(1,L);
for i=1:L
    variances(i)=sigb(i,p,L);
end
variances=sqrt(variances);
yyaxis right
ylabel('Inter Class Variance');
plot(variances);


xl = xline(L*T,'-.','Upper Threshold','DisplayName','Upper Threshold');
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'center';
legend('show');
hold off;

function [res] =  sigb(t,p,L)
    [w0,w1] = om(t,p,L);
    [mu0,mu1] = mu(t,p,L);
    res=w0*w1*(mu0-mu1)^2;
    
end
function [ mu0,mu1 ] = mu(t,p,L)
    mu0=0;
    mu1=0;
    
    [w0,w1] = om(t,p,L);
    
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


function [t,sigma_b_squared] = otsuthresh(counts)


validateattributes(counts, {'numeric'}, {'real','nonsparse','vector','nonnegative','finite'}, mfilename, 'COUNTS');

num_bins = numel(counts);

% Make counts a double column vector
counts = double( counts(:) );

% Variables names are chosen to be similar to the formulas in
% the Otsu paper.
p = counts / sum(counts);
omega = cumsum(p);
mu = cumsum(p .* (1:num_bins)');
mu_t = mu(end);

sigma_b_squared = (mu_t * omega - mu).^2 ./ (omega .* (1 - omega));

% Find the location of the maximum value of sigma_b_squared.
% The maximum may extend over several bins, so average together the
% locations.  If maxval is NaN, meaning that sigma_b_squared is all NaN,
% then return 0.
maxval = max(sigma_b_squared);
isfinite_maxval = isfinite(maxval);
if isfinite_maxval
    idx = mean(find(sigma_b_squared == maxval));
    % Normalize the threshold to the range [0, 1].
    t = (idx - 1) / (num_bins - 1);
else
    t = 0.0;
end
end