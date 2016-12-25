function err = cross_validate(dataset, num_folds, train_method, test_method, distance_measure)

% Partition dataset.
[train_set, test_set] = partition_dataset(dataset, num_folds);
% Train model.
model = train_method(train_set);
% Verify the results.
num_correct = 0;
num_test = length(test_set);
for i=1:num_test
    label = test_method(model, test_set(i), distance_measure);
    if strcmp(test_set(i).label, label)
        num_correct = num_correct + 1;
    end
end
% Final results.
err = (num_test-num_correct)/num_test;

end