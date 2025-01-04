
function collision_list = collsion_check_function(drone_list, X_new, Y_new, Z_new, collision_threshold)

% Initialize a single list to store drones with potential collisions
collision_list = [];

% Collision detection loop
for drone1 = 1:length(drone_list)
    
        % Initialize a flag to check if a collision occurred between drone1 and drone2
        collision_detected = false;     
        for drone2 = drone1 + 1:length(drone_list)
             for waypoint = 1:size(X_new, 1)-1
                p1=[X_new(waypoint, drone1),Y_new(waypoint, drone1), Z_new(waypoint, drone1)];
                q1=[X_new(waypoint+1, drone1),Y_new(waypoint+1, drone1), Z_new(waypoint+1, drone1)];

                p2=[X_new(waypoint, drone2),Y_new(waypoint, drone2), Z_new(waypoint, drone2)];
                q2=[X_new(waypoint+1, drone2),Y_new(waypoint+1, drone2), Z_new(waypoint+1, drone2)];

                % Compute the shortest distance and closest points
                distance = closestDistanceBetweenLinesPoints(p1, q1, p2, q2);

    
                % Check for collision and add drone1 to the collision list if a collision is detected
                if distance < collision_threshold
                    collision_list = [collision_list, drone1];
                    collision_detected = true; % Set the flag to true
                    break; % Exit the waypoint loop since a collision is detected
                end
            end
        
            % If a collision is detected between drone2 and drone1, break and move on to the next drone
            if collision_detected
                break;
            end
        end
end

% Remove duplicate entries from the collision list
collision_list = unique(collision_list);
