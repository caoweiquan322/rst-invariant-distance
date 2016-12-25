function [train_set, test_set] = partition_dataset(dataset, num_folds)

% Get number train, number test.
num_instances = length(dataset);
num_test = round(num_instances/num_folds);
num_train = num_instances - num_test;

% Partition.
idx = randperm(num_instances);
train_set = struct('label', cell(num_train, 1),...
    'data', cell(num_train, 1));
for i=1:num_train
    train_set(i).label = dataset(idx(i)).label;
    train_set(i).data = dataset(idx(i)).data;
end
test_set = struct('label', cell(num_test, 1),...
    'data', cell(num_test, 1));
for i=1:num_test
    test_set(i).label = dataset(idx(i+num_train)).label;
    test_set(i).data = dataset(idx(i+num_train)).data;
end

end