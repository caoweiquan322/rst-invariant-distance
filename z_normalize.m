function xyz = z_normalize(xyz)

xyz = xyz-repmat(mean(xyz), size(xyz, 1), 1);

% [~, ~, lambda] = pca(xyz);
% xyz = xyz/sqrt(lambda(1));

scale = mean(sqrt(sum(xyz.^2, 2)));
xyz = xyz/scale;

end