function [x, y, z] = read_auslan(filepath)

% Data parsing.
[x,y,z,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = textread(filepath,...
    '%f%f%f%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s',...
    'delimiter', ',', 'headerlines', 0);

end