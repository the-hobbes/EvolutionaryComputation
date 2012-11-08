function traversal( tree )
%TRAVERSAL Testing recursive tree traversal (preOrder Traversal)
%
% Explore the tree in preOrder, going along the left side and enumerating
% each node as you go.

    if tree.nodes == 1
    % if the node is a terminal, just print the node operator
        tree.op %print current tree node
        
    else
    % otherwise, the node is a function and must itself be explored
        tree.op %print current tree node
        for i=1:size(tree.kids,2)
            traversal(tree.kids{i})
        end
    end
end