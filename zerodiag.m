function [ wmnodiag ] = zerodiag( weights_matrix )

% Code to zero the diagonal of a weighted matrix
% Author & copyright: Karlo Hock, University of Queensland. 2019


for i = 1:size(weights_matrix,3)
    for j = 1:size(weights_matrix,1)
        weights_matrix(j,j,i) = 0;
    end
end
wmnodiag = weights_matrix;

end

