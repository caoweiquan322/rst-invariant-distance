function [feat, x, y, z] = extract_align_free_context(x, y, z, N, reference_weights)

% Set visualizing to false by default.
is_visualize = false;
% Visualize the original data.
if is_visualize
    figure(1);
    subplot(1, 2, 1);
    plot3(x, y, z, '*-r');
    title('Original');
end

% Pre-process the trajectory.
% Re-sampling.
acc_len = cumsum(sqrt(diff(x).^2 + diff(y).^2 + diff(z).^2));
if size(acc_len, 1) == 1
    acc_len = [0, acc_len];
else
    acc_len = [0; acc_len];
end
nx = zeros(N, 1); ny = zeros(N, 1); nz = zeros(N, 1);
nx(1) = x(1); ny(1) = y(1); nz(1) = z(1);
nx(end) = x(end); ny(end) = y(end); nz(end) = z(end);
step = acc_len(end)/(N-1);
j = 2;
for i=2:N-1
    pos = (i-1)*step;
    while acc_len(j) < pos, j=j+1; end
    u = (pos-acc_len(j-1))/(acc_len(j)-acc_len(j-1));
    v = 1-u;
    nx(i) = u*x(j)+v*x(j-1);
    ny(i) = u*y(j)+v*y(j-1);
    nz(i) = u*z(j)+v*z(j-1);
end
x = nx; y = ny; z = nz;
% sqrt(diff(x).^2 + diff(y).^2 + diff(z).^2);
% Normalizing.
entire_std = norm([std(x) std(y) std(z)]);
x= (x-mean(x))/entire_std;
y= (y-mean(y))/entire_std;
z= (z-mean(z))/entire_std;
% Smoothing.
x = medfilt1(x, 3);
y = medfilt1(y, 3);
z = medfilt1(z, 3);

% Visualize the data.
if is_visualize
    figure(1);
    subplot(1, 2, 2);
    plot3(x, y, z, '*-g');
    title('After pre-process');
end

% Extract RST invariant features.
lambda = size(reference_weights, 2);
reference_positions = zeros(lambda, 3);
for j=1:lambda
    reference_positions(j,:) = [dot(x, reference_weights(:,1)),...
        dot(y, reference_weights(:,2)),...
        dot(z, reference_weights(:,3))];
end
feat = zeros(N, lambda);
for i=1:N
    for j=1:lambda
        feat(i, j) = norm([x(i)-reference_positions(j,1),...
            y(i)-reference_positions(j,2),...
            z(i)-reference_positions(j,3)]);
    end
end

end