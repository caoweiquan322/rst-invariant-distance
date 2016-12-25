function [Dist] = rst_inv_ed(t, r)

% Normalize the trajectories.
t = resample(z_normalize(t), 60);
r = resample(z_normalize(r), 60);
% t = resample((t), 60);
% r = resample((r), 60);

% Estimate the rotation matrix.
[u, ~, v] = svd(r'*t);
R = v*u';
r2 = r*R';

% Calculate the distance.
Dist = ed(t, r2);

end