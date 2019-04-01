n=100;
clear all;
close all;
n=300;

x=linspace(-1,1,n);
m=1;
b=0;
y=linspace(-1,1,n);
y_scaler=8;
x_scaler=8;
for i=1:n
    perturbation = (2*rand(1)-1)/y_scaler;
    y(i)=y(i)+perturbation;
    perturbation = (2*rand(1)-1)/x_scaler;
    x(i)=x(i)+perturbation;
end

dat=zeros(n,2);
dat=[x(:),y(:)];

scatter(dat(:,1),dat(:,2),'filled');
xlabel("X");
ylabel("Y");
set(gca, 'YAxisLocation', 'origin')
set(gca, 'XAxisLocation', 'origin')
axis([-1 1 -1 1]);