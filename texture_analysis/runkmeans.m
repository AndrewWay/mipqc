opts = statset('Display','final');
[idx,C] = kmeans(W,4,'Distance','cityblock',...
    'Replicates',5,'Options',opts);
figure(1);
xlabel("Projection of data along first principal component");
ylabel("Projection of data along second principal component");
plot(W(idx==1,1),W(idx==1,2),'r.','MarkerSize',12)
hold on
plot(W(idx==2,1),W(idx==2,2),'g.','MarkerSize',12)
hold on
plot(W(idx==3,1),W(idx==3,2),'b.','MarkerSize',12)
hold on
plot(W(idx==4,1),W(idx==4,2),'y.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
    'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Cluster 3',...
    'Cluster 4','Centroids',...
    'Location','NW')
title 'Cluster Assignments and Centroids'
hold off