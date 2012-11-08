function [tree1, tree2] = customuniform3(tree1,tree2)
%function [tree1, tree2] = customuniform(tree1,tree2)
% A recursive function that takes in two trees and applies uniform
% crossover to them, producing two recombined versions of the trees.

p=1; %just for now I hardcoded the probability with which the nodes are swaped

numkids1=size(tree1.kids,2); %changed to size(tree1.kids,2), as we want number of columns
numkids2=size(tree2.kids,2);

%minkids=min(size(tree1.kids,1),size(tree2.kids,1)); %look at how many branches lead from the current nodes we're looking at and pick the lower number.

n=rand(1);
%if we are at the lowest level and there are no branches, swap nodes
if ((numkids1==0 && numkids2 ~= 0) || (numkids1~=0 && numkids2 == 0)) && n<=p
    
    [tree1,tree2]=swapnodes(tree1,tree2,tree1.nodeid,tree2.nodeid);                                               
        
else %case where both of the nodes we're currently looking at are branching further
    if tree1.nodeid==1 && numkids1==numkids2 %case for root node
        n=rand(1);
        if n<=p
            a=tree1.op;
            b=tree2.op;
            tree1.op=b;
            tree2.op=a; %if this is the first level of recursion we should swap the top nodes with prob p.
        end

        %enter recurion at the next node level
        firstKid = tree1.kids{2};
        secondKid = tree2.kids{2};
        [tree1, tree2]=customuniform3(firstKid,secondKid);
        
    %elseif tree1.nodeid~=1 && numkids1==numkids2
    else
        for i=1:numkids1
            n=rand(1);
            if n<=p
                a=tree1.op;
                b=tree2.op;
                tree1.op=b;
                tree2.op=a; %and then we should swap the overlapping nodes underneath them with prob p
            end
            [tree1.kids{i}, tree2.kids{i}]=customuniform3(tree1.kids{i},tree2.kids{i}); %go down one level 
        %in the recursion and run the function for each of the overlapping couples of nodes underneath the current nodes
        end
    end    
end
end

