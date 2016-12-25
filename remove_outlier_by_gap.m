function xyz = remove_outlier_by_gap(xyz, thresh)

% Get the gaps' length.
gap = [0; sum(diff(xyz).^2, 2)];
final_thresh = thresh*thresh*median(gap(gap>0));
idx = gap>0 & gap<final_thresh;
xyz = [xyz(1,:);
    xyz(idx,:)];

end