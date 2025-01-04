function batchList = batching(collisionList, uavs, batchList, X_new, Y_new, Z_new, collision_threshold)
    % Initialize batchList size
    listSize = numel(batchList);
    
    % Initialize group1 with all UAVs
    group1 = uavs;
    
    % Get group2 using collisionList
    group2 = collisionList;
    
    % Remove elements from group1 that are also in group2
    group1 = setdiff(group1, group2);
    
    if numel(group2) > 1
        % Add group1 to batchList
        batchList{listSize + 1} = group1;
        
        % Detect collisions in group2
        collisionListAux = collsion_check_function(collisionList, X_new, Y_new, Z_new, collision_threshold);
        
        if isempty(collisionListAux)
            % Add group2 to batchList
            batchList{listSize + 2} = group2;
        else
            % Create uavsAux with the size of group2
            uavsAux = group2;
            
            % Recursively call batching with collisionListAux, uavsAux, and batchList
            batchList = batching(collisionListAux, uavsAux, batchList,X_new, Y_new, Z_new, collision_threshold);
        end
    else
        % Add group1 to batchList if it's not empty
        if ~isempty(group1)
            batchList{listSize + 1} = group1;
        end
        
        % Add group2 to batchList if it's not empty
        if ~isempty(group2)
            batchList{listSize + 2} = group2;
        end
    end
end