function distance = closestDistanceBetweenLinesPoints(start1, end1, start2, end2)
    % Inputs:
    % start1, end1: Starting and ending points of line 1 (1x3 vectors)
    % start2, end2: Starting and ending points of line 2 (1x3 vectors)
    %
    % Output:
    % distance: The shortest distance between the two lines
    
    % Direction vectors of the two lines
    r = end1 - start1; % Direction vector of line 1
    s = end2 - start2; % Direction vector of line 2
    
    % Normal vector perpendicular to both lines
    n = cross(r, s);
    
    % Check if lines are parallel (n will be zero if they are parallel)
    if norm(n) == 0
        % Lines are parallel, calculate perpendicular distance from one point to the other line
        distance = norm(cross(start2 - start1, r)) / norm(r);
        return;
    end
    
    % Normalize the normal vector
    n = n / norm(n);
    
    % Vector connecting any point on line 1 to any point on line 2
    d = start2 - start1;
    
    % Project d onto the normal vector to find the shortest distance
    distance = abs(dot(d, n));
end