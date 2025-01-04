function [X_new, Y_new, Z_new, batching_list] = collision_avoidance(X_new, Y_new, Z_new, drone1_index, drone2_index, collision_waypoint, correction, trajectory_changes, batching_list)
    j = 1; % MATLAB uses one-based indexing
    k = 5; % Window size for adjustment
    num_waypoints = size(Z_new, 1); % Number of waypoints
    if trajectory_changes(drone1_index) < 10
        % Adjust trajectory for drone1 based on collision waypoint and correction
        for i = max(collision_waypoint - k, 1):min(collision_waypoint + k, num_waypoints)
            Z_new(i, drone1_index) = Z_new(i, drone1_index) + correction(j);
            j = j + 1;
        end
        trajectory_changes(drone1_index) = trajectory_changes(drone1_index) + 1;
        [X_new, Y_new, Z_new, batching_list] = collision_detection(X_new, Y_new, Z_new, batching_list, trajectory_changes);

    elseif trajectory_changes(drone2_index) < 10
        % Adjust trajectory for drone2 based on collision waypoint and correction
        for i = max(collision_waypoint - k, 1):min(collision_waypoint + k, num_waypoints)
            Z_new(i, drone2_index) = Z_new(i, drone2_index) + correction(j);
            j = j + 1;
        end
        trajectory_changes(drone2_index) = trajectory_changes(drone2_index) + 1;
        [X_new, Y_new, Z_new, batching_list] = collision_detection(X_new, Y_new, Z_new, batching_list, trajectory_changes);

    else
        % Add both drones to the batching list
        batching_list = [batching_list, drone1_index, drone2_index];
    end
end
