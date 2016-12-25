function [all_data, distinct_labels] = load_all_auslan(auslan_dir_path)

sub_dirs = dir([auslan_dir_path '/*']);
% Count for files number first.
count = 0;
for i=1:length(sub_dirs)
    if strcmp(sub_dirs(i).name(1), '.'), continue; end
    % Read files one by one.
    files = dir([auslan_dir_path '/' sub_dirs(i).name '/*.sign']);
    for k=1:length(files)
        file_path = [auslan_dir_path '/' sub_dirs(i).name '/' files(k).name];
        if ~exist(file_path, 'file'), continue; end
        count = count+1;
    end
end
fprintf('There are %d files in total.\n', count);

% Construct all the data here.
all_data = struct('path', cell(count, 1), 'label', cell(count, 1), 'data', cell(count, 1));
itr = 0;
for i=1:length(sub_dirs)
    if strcmp(sub_dirs(i).name(1), '.'), continue; end
    %fprintf('Loading folder %s.\n', sub_dirs(i).name);
    % Read files one by one.
    files = dir([auslan_dir_path '/' sub_dirs(i).name '/*.sign']);
    for k=1:length(files)
        file_path = [auslan_dir_path '/' sub_dirs(i).name '/' files(k).name];
        if ~exist(file_path, 'file'), continue; end

        % Read auslan data.
        [x, y, z] = read_auslan(file_path);
        itr = itr+1;
        all_data(itr).path = file_path;
        all_data(itr).label = files(k).name(1:end-6);
        all_data(itr).data = [x, y, z];
    end
end

end