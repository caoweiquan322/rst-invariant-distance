function [Dist,D,k,w] = rst_inv_dtw(t, r)

% Normalize the trajectories.
t = resample(z_normalize(t), 60);
r = resample(z_normalize(r), 60);

% Estimate the rotation matrix.
[u, ~, v] = svd(r'*t);
R = v*u';
r2 = r*R';

% Calculate the distance.
[Dist, D, k, w] = dtw(t, r2);

end