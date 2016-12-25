function xyz = remove_outlier_by_curvature(xyz, thresh)

% Get the curvatures.
p1 = xyz(1:end-2, :);
p2 = xyz(2:end-1, :);
p3 = xyz(3:end, :);
d1 = sqrt(sum(diff(p2-p1).^2, 2));
d2 = sqrt(sum(diff(p3-p2).^2, 2));
d3 = sqrt(sum(diff(p3-p1).^2, 2));
dm = (d1+d2+d3)/2;
curvature = [0;
    4*sqrt(dm.*(dm-d1).*(dm-d2).*(dm-d3))./d1./d2./d3];
% plot(curvature);

% Filter the outliers.
final_thresh = thresh*median(curvature(~isnan(curvature)));
idx = ~isnan(curvature) & curvature<final_thresh;
xyz = [xyz(1,:);
    xyz(idx,:);
    xyz(end,:)];

end