function [v,b]=demo_phelan
%DEMO_PHELAN    custom function to test modifications taken from demo
%               template.
%   DEMO_PHELAN runs a time series prediction problem for custom input
%   with 100 individuals for 25 generations,
%   with automatic adaptation of operator probabilities,
%   and drawing two additional post-run plots.
%
%   VARS=DEMO returns all the variables of the algorithm
%   needed to plot charts, continue runs, draw trees, etc.
%
%   [VARS,BEST]=DEMO also returns the best individual found
%   during the run (the same as 'vars.state.bestsofar').
%
%   See also DEMOPARITY,DEMOANT,DEMOPLEXER
%
%   Copyright (C) 2003-2007 Sara Silva (sara@dei.uc.pt)
%   Modified by Phelan Vendeville pvendevi@uvm.edu
%   This file is part of the GPLAB Toolbox


p=resetparams;

%p=setoperators(p,'crossover',2,2,'mutation',1,1);
p=setoperators(p,'uniformcrossover',2,2,'mutation',1,1);

p.operatorprobstype='variable';
p.minprob=0;

%source files
p.datafilex='test_lag_x.txt';
p.datafiley='test_lag_y.txt';

p.calcfitness= 'RMSE_fitness'; %set parameters to use custom fitness function

p.usetestdata=0; %no test data

p.initpoptype = 'fullinit';

p.graphics={}; %no graphics
p.depthnodes='1';

[v,b]=gplab(25,50,p);

figure
plotpareto(v);

drawtree(b.tree);