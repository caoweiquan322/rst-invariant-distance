sub_data = rand_sub_data(all_data, 4);

% Translate and rotate the data randomly.
for k=1:length(sub_data)
    sub_data(k).data = rand_translate(rand_rotate(sub_data(k).data));
end

% Filter the data.
u=10;
r = 30;
dt = 1;
for k=1:length(sub_data)
    [x, vx] = kalman_filter(sub_data(k).data(:, 1), dt, u, r);
    [y, vy] = kalman_filter(sub_data(k).data(:, 2), dt, u, r);
    [z, vz] = kalman_filter(sub_data(k).data(:, 3), dt, u, r);
    %sub_data(k).data = [x, y, z];
end

tic;
err = cross_validate(sub_data, 10, @train_knn_model, @test_knn_model, @dtw);
cv_time = toc;
fprintf('Cross validate error of dtw is %.2f%% within %.3f secs.\n', err*100, cv_time);
tic;
err = cross_validate(sub_data, 10, @train_knn_model, @test_knn_model, @rst_inv_dtw);
cv_time = toc;
fprintf('Cross validate error of rst_inv_dtw is %.2f%% within %.3f secs.\n', err*100, cv_time);