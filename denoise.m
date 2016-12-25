function [nxyz] = denoise(xyz, filter, level)

while level > 0.5
    % Denoise by one step.
    [A1, ~] = dwt(xyz(:,1), filter);
    [A2, ~] = dwt(xyz(:,2), filter);
    [A3, ~] = dwt(xyz(:,3), filter);
    xyz = [A1, A2, A3];
    level = level - 1;
end
nxyz = xyz;

end