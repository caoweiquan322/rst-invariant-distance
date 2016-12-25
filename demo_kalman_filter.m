idx = randi(length(all_data));
od = all_data(idx).data;

u=10;
r = 300;
dt = 1;
[x, ~] = kalman_filter(od(:, 1), dt, u, r);
[y, ~] = kalman_filter(od(:, 2), dt, u, r);
[z, ~] = kalman_filter(od(:, 3), dt, u, r);
td = [x y z];
close all;
figure;
plot(od(:,1), od(:,2), 'r-*');
hold on;
plot(td(:,1), td(:,2), 'g-+');
plot(td(1,1), td(1,2), 'ks');
plot(td(end,1), td(end,2), 'ko');