sub_data = rand_sub_data(all_data, 4);

u=10;
r = 30;
dt = 1;
for k=1:length(sub_data)
    [x, vx] = kalman_filter(sub_data(k).data(:, 1), dt, u, r);
    [y, vy] = kalman_filter(sub_data(k).data(:, 2), dt, u, r);
    [z, vz] = kalman_filter(sub_data(k).data(:, 3), dt, u, r);
    %sub_data(k).data = [x, y, z];
end

err = cross_validate(sub_data, 10, @train_knn_model, @test_knn_model, @dtw);