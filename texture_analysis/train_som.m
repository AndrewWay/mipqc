%http://www.ai-junkie.com/ann/som/som4.html
%Each node contains a vector of weights of the same dimension as input vecs

%Initialize SOM
%Set each vector in the SOM to a vector of random weights
nObservations=size(data,1);
numberOfNeurons = 5*sqrt(nObservations);
%y is the longer side
%x is the shorter side

som_dim1 = ceil(sqrt(2*numberOfNeurons));
som_dim2 = ceil(0.5*som_dim1);

net = selforgmap([som_dim1 som_dim2]);

inputs=W';

[net, tr] =train(net,inputs);