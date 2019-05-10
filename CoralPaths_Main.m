% Script to calculate the calculate three metrics:
% 1) minimum number of stepping stones between two nodes,
% 2) most reliable path between two nodes, and 
% 3) maximum flow between two nodes 
% This code supplements the article "Asymmetric dispersal is a critical element of concordance between 
% biophysical dispersal models and spatial genetic structure in Great
% Barrier Reef corals" by Riginos, Hock, et al.
% Author & copyright: Karlo Hock, University of Queensland. 2019


% First load the necessary data; the data file contains:
% connectvity = yearly Acropora connectivity matrices for the Great Barrier Reef; for details see upcoming Hock et al. article on Acropora split spanwing
% probabilitymat = probability of dispersal between two reefs
% logprobmat = negative log-transformed probabilities to calcualte MRP, precalculated for faster processing; see Hock & Mumby (2015) J Roy Soc Interface
% sitesMillepora and sitesTenuis = list of reefs that need to be looked up in calculations; see excel tables to know which index corrsponds to which reef
% ReefSizes = sizes of individual reef polygons; derived from  GBRMPA GIS file available at http://www.gbrmpa.gov.au/resources-and-publications/spatial-data-information-services

load CoralPaths.mat

%calculate the metrics for Tenuis sites
results_Tenuis  = CoralPaths_f( connectivity, sitesTenuis, probabilitymat, logprobmat, ReefSizes );

%calculate the metrics for Millepora sites
results_Millepora  = CoralPaths_f( connectivity, sitesMillepora, probabilitymat, logprobmat, ReefSizes );