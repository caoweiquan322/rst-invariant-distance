% Generate data.
% rng(5);
sub_data = rand_sub_data(all_data, 1);
X1 = sub_data(randi(length(sub_data))).data;
X1 = X1-repmat(mean(X1), size(X1, 1), 1);
[~, ~, lambda] = pca(X1);
X1 = X1/sqrt(lambda(1));
X2 = X1;%*rx(2*pi*rand())*ry(2*pi*rand())*rz(2*pi*rand());

X1 = sub_data(randi(length(sub_data))).data;
X1 = X1-repmat(mean(X1), size(X1, 1), 1);
[~, ~, lambda] = pca(X1);
X1 = X1/sqrt(lambda(1));

% Resample the data to ensure that they are of the same size.
X1 = resample(X1, 60);
X2 = resample(X2, 60);

% Visualize data.
plot(X1(:, 1), X1(:, 2), 'g--');
hold on;
plot(X2(:, 1), X2(:, 2), 'r--');

% Estimate the optimal R matrix such that ||X1-RX2|| is minimized.
[u, s, v] = svd(X2'*X1);
R = v*u';
X3 = X2*R';

% Visualize the rotated X2.
plot(X3(:, 1), X3(:, 2), 'ko');