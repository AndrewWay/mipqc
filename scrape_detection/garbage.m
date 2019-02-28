nSamp=10000;
mu=0;
sg=[0.05 0.1 0.3];
H=normrnd(mu,repmat(sg,nSamp,1));
hist(H,100), xlim([-1.3 1.3])