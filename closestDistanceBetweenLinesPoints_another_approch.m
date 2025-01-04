
function distance = closestDistanceBetweenLinesPoints(p1_start, p1_end, p2_start, p2_end)
    % Calculate direction vectors from start and end points
    d1 = p1_end - p1_start; % Direction vector of Line 1
    d2 = p2_end - p2_start; % Direction vector of Line 2
    
    % Ensure direction vectors are normalized
    d1 = d1 / norm(d1);
    d2 = d2 / norm(d2);
    
    % Cross product of direction vectors
    n = cross(d1, d2);
    n_norm = norm(n);
    
    % If the lines are parallel (n_norm = 0), handle as a special case
    if n_norm == 0
        %set distance to the big numbe
        distance=10;
        return;
    end
    
    % Compute n1 and n2
    n1 = cross(d1, n);
    n2 = cross(d2, n);
    
    % Compute the closest point c1 on Line 1
    t1 = dot(p2_start - p1_start, n2) / dot(d1, n2);
    c1 = p1_start + t1 * d1;
    
    % Compute the closest point c2 on Line 2
    t2 = dot(p1_start - p2_start, n1) / dot(d2, n1);
    c2 = p2_start + t2 * d2;
    
    % Compute the minimum distance
    distance = norm(c1 - c2);
end
