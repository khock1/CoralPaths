function [ results ] = CoralPaths_f( connectivity, sites, probabilitymat, logprobmat, sizes )

% Code to calculate the calculate 1) minimum number of stepping stones, 2) most
% reliable path, and 3) maximum flow between two nodes 
% To accompany article "Asymmetric dispersal is a critical element of concordance between 
% biophysical dispersal models and spatial genetic structure in Great
% Barrier Reef corals" by Riginos et al.
% Author & copyright: Karlo Hock, University of Queensland. 2019

net1=connectivity(1).Net2008;
net2=connectivity(1).Net2010;
net3=connectivity(1).Net2011;
net4=connectivity(1).Net2012;

%multiply link weights by reef size to scale the outputs
for i=1:length(net1)
    for j=1:length(net1)
        net1(i,j)=net1(i,j)*sizes(i,2);
        net2(i,j)=net2(i,j)*sizes(i,2);
        net3(i,j)=net3(i,j)*sizes(i,2);
        net4(i,j)=net4(i,j)*sizes(i,2);
    end
end
%cumulative connectvity over 4 years
cumulativenet=net1+net2+net3+net4;
%cumualtive adjacency network; all links that existed over 4 years set to 1
adjacencynet=cumulativenet;
adjacencynet(adjacencynet>0)=1;

[x,y,w]=find(zerodiag(cumulativenet));
G = digraph(x,y,w);

stepstonnet=zeros(length(sites));%number of stepping stones
MRPnet=zeros(length(sites));%most reliable paths
maxflownet=zeros(length(sites));%maximum flow from cumulative connectvity network

for i=1:length(sites)
    for j=1:length(sites)
        %calculate number fo steppign stones usign adjaceny network with the classical shortest path algorithm
        [stepstonnet(i,j),~,~] = graphshortestpath(sparse(adjacencynet),sites(i,1),sites(j,1));
        
        %calculate 
        MRPnet(i,j)=MRP_calc( probabilitymat, sites(i,1), sites(j,1), logprobmat);
        if i~=j
            maxflownet(i,j)= maxflow(G,sites(i),sites(j));
        end
    end
end
results=struct('SteppingStones',[],'MostReliablePath',[],'MaxFlow',[]);
results.SteppingStones=stepstonnet;
results.MostReliablePath=MRPnet;
results.MaxFlow=maxflownet;

end