function [ tree1, tree2 ] = uniformCrossover_phelan( tree1, tree2, crossProb )
%UNIFORMCROSSOVER_PHELAN Function to perform uniform crossover on common
%regions of the trees.
%
%look at the current node in each tree
    %if the arity is the same, swap those nodes between the two trees
    %if the arity is different (you are at the edge of the common region)
        %if the nodes are terminals (no children), swap them
        %if the nodes are functions (>= 1 child), swap subtrees
        
    %get arity of the current node
    tree1_arity = size(tree1.kids,2);
    tree2_arity = size(tree2.kids,2);

    if tree1_arity == tree2_arity
        %if the arities are the same, we can just swap the nodes with some
        %prob.
        n=rand(1);
        if n <= crossProb        
            a=tree1.op;
            b=tree2.op;
            tree1.op=b;
            tree2.op=a;
        end
        
        %then recurse
        for i=1:min(size(tree1.kids,2), size(tree2.kids,2))
             [ tree1.kids{i}, tree2.kids{i} ] = uniformCrossover_phelan(tree1.kids{i}, tree2.kids{i}, crossProb);
        end
            
        else
        %if the node is a function, swap the subtrees            
        %[tree1, tree2]=swapnodes(tree1, tree2, tree2.nodeid, tree1.nodeid);
            
            n=rand(1);
            if n <= crossProb  
                tempTree1 = tree1;
                tempTree2 = tree2;
                tree1 = tempTree2;
                tree2 = tempTree1;
            end
            
        end
        
        %then recurse
        for i=1:min(size(tree1.kids,2), size(tree2.kids,2))
             [ tree1.kids{i}, tree2.kids{i} ] = uniformCrossover_phelan(tree1.kids{i}, tree2.kids{i}, crossProb);
        end  
%     end
end

