% Choose one trajectory randomly.
%sub_data = rand_sub_data(all_data, 3);
num_data = length(sub_data);
idx = randi(num_data);
traj = sub_data(idx).data;

% Pre-process.
u=10;
r = 30;
dt = 1;
[x, vx] = kalman_filter(traj(:, 1), dt, u, r);
[y, vy] = kalman_filter(traj(:, 2), dt, u, r);
[z, vz] = kalman_filter(traj(:, 3), dt, u, r);
traj = [x, y, z];
traj = resample(traj, 60);
subplot(2, 2, 1);
plot(sub_data(idx).data(:, 1), sub_data(idx).data(:, 2), '--+');
hold on;
plot(traj(:, 1), traj(:, 2), '--o');
plot(traj(1, 1), traj(1, 2), 's',...
    'MarkerFaceColor', 'r',...
    'MarkerEdgeColor', 'k',...
    'MarkerSize', 12);
plot(traj(end, 1), traj(end, 2), 'o',...
    'MarkerFaceColor', 'r',...
    'MarkerEdgeColor', 'k',...
    'MarkerSize', 12);
subplot(2, 2, 2);
plot(sqrt(vx.^2+vy.^2+vz.^2), '-*g');
hold on;
plot(sqrt(sum(diff([x y z]).^2, 2)), '-+r');

% Extract curvature features.
[feat, r, cum_s] = mix_signature(traj);
subplot(2, 2, 3);
plot(feat, 'g--+');
hold on;
nfeat = kalman_filter(feat, dt, 10, 30);
plot(nfeat, 'r-*');

% The cdf function.
subplot(2, 2, 4);
plot(r, 'g--+');