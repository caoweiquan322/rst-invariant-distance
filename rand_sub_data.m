function sub_data = rand_sub_data(all_data, num_classes)

% Specify the cared labels by random.
cared_labels = cell(num_classes, 1);
count = 0;
num_instances = length(all_data);
sub_size = 0;
while count<num_classes
    label = all_data(randi(num_instances)).label;
    if sum(strcmp(label, cared_labels))==0
        count = count+1;
        cared_labels{count} = label;
        sub_size = sub_size + sum(strcmp(label, {all_data.label}));
    end
end
fprintf('Extracted %d instances from %d classes.\n', sub_size, num_classes);

% Store the corresponding instances here.
count = 0;
sub_data = struct('label', cell(sub_size, 1),...
    'data', cell(sub_size, 1));
for i=1:num_instances
    for j=1:num_classes
        if strcmp(cared_labels{j}, all_data(i).label)
            count = count + 1;
            sub_data(count).label = all_data(i).label;
            sub_data(count).data = all_data(i).data;
            break;
        end
    end
end

end