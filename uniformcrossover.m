function newinds=uniformcrossover(pop,params,state,indlist)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

i1=indlist(1);
i2=indlist(2);

ind1=pop(i1);
ind2=pop(i2);

if isempty(ind1.nodes)
   ind1.nodes=nodes(ind1.tree);
end
if isempty(ind2.nodes)
   ind2.nodes=nodes(ind2.tree);
end

% drawtree(ind1.tree);
% drawtree(ind2.tree);

[ind1.tree, ind2.tree] = uniformCrossover_phelan(ind1.tree,ind2.tree, 1);

ind1.str=tree2str(ind1.tree);
ind1.id=[];
ind1.origin='crossover';
ind1.parents=[pop(i1).id,pop(i2).id];
ind1.xsites=[];
ind1.fitness=[];
ind1.adjustedfitness=[];
ind1.result=[];
ind1.testfitness=[];
ind1.testadjustedfitness=[];
ind1.level=[];
ind1.nodes=ind1.tree.nodes;
ind1.introns=[];
   
ind2.str=tree2str(ind2.tree);      	
ind2.id=[];
ind2.origin='crossover';
ind2.parents=[pop(i2).id,pop(i1).id];
ind2.xsites=[];
ind2.fitness=[];
ind2.adjustedfitness=[];
ind2.result=[];
ind2.testfitness=[];
ind2.testadjustedfitness=[];
ind2.level=[];
ind2.nodes=ind2.tree.nodes;
ind2.introns=[];

% tree1 = ind1.tree;
% tree2 = ind2.tree;
% 
% newind1=tree1;
% newind2=tree2;

newind1=ind1;
newind2=ind2;

newinds=[newind1,newind2];
