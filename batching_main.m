% Load the data file
% %load('modified_trajectories_6.mat');

% % 
X_new = X;
Y_new = Y;
Z_new = Z;

% List of all drones
drone_list = 1:500; % List of all 500 drones

% Collision threshold
% Here 0.03 is radius of UAV
collision_threshold = 0.03+0.03;

% Call the general_collision_detection function to detect collisions among all drones
collisionList = collsion_check_function(drone_list, X_new, Y_new, Z_new, collision_threshold);

% List of all UAVs
uavs = 1:500;

% Initialize an empty cell array for batchList
batchList = {};

% Call the batchGe function to generate batches using the collisionList for all 500 drones
resultingBatchList = batching(collisionList, uavs, batchList, X_new, Y_new, Z_new, collision_threshold);

% Display the generated batches
for i = 1:numel(resultingBatchList)
    fprintf('Batch %d: %s\n', i, num2str(resultingBatchList{i}));
end