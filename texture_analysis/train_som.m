%http://www.ai-junkie.com/ann/som/som4.html
%Each node contains a vector of weights of the same dimension as input vecs

%Initialize SOM
%Set each vector in the SOM to a vector of random weights

numberOfNeurons = (5*sqrt(nObservations));
som_dim1 = floor(sqrt(2*numberOfNeurons));%60
som_dim2=floor(som_dim1/2);%32

net = selforgmap([som_dim1 som_dim2]);

inputs=W';

[net, tr] =train(net,inputs);