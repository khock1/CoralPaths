function cumulativeprob = MRP_calc( probabilitymat, source, target, logprobabilitymat )

% Code to calculate the calculate cumulative probability/most reliable
% path of dispersal between given source and target in a given log-transformed matrix
% Author & copyright: Karlo Hock, University of Queensland. 2019

if ~issparse(logprobabilitymat)
    Slogmat = sparse(logprobabilitymat);
end

%get all nodes on a MRP using the shortest path algorithm on a log-transformed matrix
[~,MRP_nodes,~] = graphshortestpath(Slogmat,source,target);

%if no path possible between nodes, cumulative probability of dispersal is zero, otherwise set to 1
if ~isempty(MRP_nodes)
    cumulativeprob = 1;
else
    cumulativeprob = 0;
end

%nodes for iteratively multiplying probabilities
node1 = 1;
node2 = 2;
%iterate between parent-child pairs of nodes on MRP to find all edge
%weights/probabilities, and multiply them to get cumulative probability
for k=1:(length(MRP_nodes)-1)
    parent = MRP_nodes(node1);
    child = MRP_nodes(node2);
    cumulativeprob = cumulativeprob*probabilitymat(parent,child);
    node1 = node1 + 1;
    node2 = node2 + 1;
end


end

