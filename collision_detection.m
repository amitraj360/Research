function [X_new,Y_new,Z_new, batching_list]= collision_detection(X_new, Y_new, Z_new, batching_list, trajectory_changes)
num_drones = 500; % Number of drones
num_waypoints = 201; % Number of waypoints

%Padding Array
total_trajectory_shift=0.03+0.03+0.025;
n = 6; % Replace 5 with the desired number of values
correction = linspace(0, total_trajectory_shift, n);
c2=linspace(total_trajectory_shift, 0, n);
c2(1)=[];
correction=horzcat(correction,c2);


collision_threshold=0.03+0.03;

% Collision detection and avoidance loop
while true
    % Store the current trajectory_changes for comparison
    prev_trajectory_changes = trajectory_changes;

    % Collision detection and avoidance loop
    for drone1 = 1:num_drones
        if ismember(drone1,batching_list)
            continue
        end
        for drone2 = 1:num_drones
            % Skip if comparing the same drone
            if drone1 == drone2 || ismember(drone2,batching_list)
                continue;
            end

            for waypoint = 1:num_waypoints-1

                p1=[X_new(waypoint, drone1),Y_new(waypoint, drone1), Z_new(waypoint, drone1)];
                q1=[X_new(waypoint+1, drone1),Y_new(waypoint+1, drone1), Z_new(waypoint+1, drone1)];

                p2=[X_new(waypoint, drone2),Y_new(waypoint, drone2), Z_new(waypoint, drone2)];
                q2=[X_new(waypoint+1, drone2),Y_new(waypoint+1, drone2), Z_new(waypoint+1, drone2)];

                % Compute the shortest distance and closest points
                distance = closestDistanceBetweenLinesPoints(p1, q1, p2, q2);

                % Check for collision
                if distance < collision_threshold
                    [X_new, Y_new, Z_new, batching_list]=collision_avoidance(X_new,Y_new,Z_new, drone1,drone2,waypoint+1, correction,trajectory_changes, batching_list);
                    if ismember(drone2,batching_list) || ismember(drone1,batching_list)
                        break
                    end
                end
            end          
        end
    end

    % Check if there were no changes in the trajectory_changes array
    if all(trajectory_changes == prev_trajectory_changes)
        save('Data_after_collision_avoidance_b_15')
        error("Collesion detection completed");
    end
end
