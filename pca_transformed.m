
[coeff,score,latent]=pca(dat);

dat=dat*coeff;

scatter(dat(:,1),dat(:,2),'filled');
xlabel("X'");
ylabel("Y'");
set(gca, 'YAxisLocation', 'origin')
set(gca, 'XAxisLocation', 'origin')
axis([-1 1 -1 1]);