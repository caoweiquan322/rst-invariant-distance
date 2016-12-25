% Configurations.
N = 60;
align_free = true;
if align_free
    lambda = 3;
    rng(5);
    reference_weights = rand(N, lambda);
    for i=1:lambda
        reference_weights(:,i) = reference_weights(:,i)/sum(reference_weights(:,i));
    end
else
    lambda = 8;
    rng(5);
    base_points = randperm(N);
    base_points = base_points(1:lambda);
end

folder1 = '/Users/fatty/Downloads/traj_class_data/AUSLAN/signs/adam1';
folder2 = '/Users/fatty/Downloads/traj_class_data/AUSLAN/signs/adam2';
files = dir([folder1 '/' '*.sign']);
for k=1:length(files)
    file_path1 = [folder1 '/' files(k).name];
    file_path2 = [folder2 '/' files(k).name];
    if ~exist(file_path1, 'file') || ~exist(file_path2, 'file'), continue; end

    % Read auslan data.
    [x, y, z] = read_auslan(file_path1);
    % Extract point context.
    if align_free
        [feat, nx, ny, nz] = extract_align_free_context(x, y, z, N, reference_weights);
    else
        [feat, nx, ny, nz] = extract_point_context(x, y, z, N, base_points);
    end
    comp_idx = 1;
    [hist_y, hist_x] = hist(feat(:,comp_idx), 10);
    subplot(1,3,1);
    plot(nx, ny, 'r');
    %plot(sort(sqrt(nx.^2+ny.^2+nz.^2)), 'r');
    title(files(k).name);
    hold on;
    subplot(1,3,2);
    plot(feat(:,comp_idx), 'r');
    hold on;
    subplot(1,3,3);
    plot(sqrt(nx.^2+ny.^2+nz.^2), 'r');
    hold on;

    % Read auslan data.
    [x, y, z] = read_auslan(file_path2);
    % Extract point context.
    if align_free
        [feat, nx, ny, nz] = extract_align_free_context(x, y, z, N, reference_weights);
    else
        [feat, nx, ny, nz] = extract_point_context(x, y, z, N, base_points);
    end
    [hist_y, hist_x] = hist(feat(:,comp_idx), 10);
    subplot(1,3,1);
    plot(nx, ny, 'g');
    %plot(sort(sqrt(nx.^2+ny.^2+nz.^2)), 'g');
    hold off;
    subplot(1,3,2);
    plot(feat(:,comp_idx), 'g');
    hold off;
    subplot(1,3,3);
    plot(sqrt(nx.^2+ny.^2+nz.^2), 'g');
    hold off;
    
    fprintf('Print any key to continue...\n');
    pause;
end