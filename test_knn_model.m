function label = test_knn_model(model, item, distance_measure)

num_instances = length(model);
distances = zeros(num_instances, 1);
for i=1:num_instances
    distances(i) = distance_measure(model(i).data, item.data);
%     distances(i) = dtw(model(i).data', item.data');
end
[~, idx] = min(distances);
label = model(idx).label;

end