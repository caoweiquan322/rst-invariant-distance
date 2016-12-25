function [feat, r, cum_s] = mix_signature(xyz)

% Calculate r.
c = mean(xyz);
r = sqrt((xyz(:,1)-c(1)).^2+(xyz(:,2)-c(2)).^2+(xyz(:,3)-c(3)).^2);

% Calculate s.
d = diff(xyz, 1, 1);
s = sqrt(sum(d.^2, 2));
cum_s = cumsum(s)/sum(s);

% Base statistics.
p1 = xyz(1:end-4,:);
p2 = xyz(2:end-3,:);
p3 = xyz(3:end-2,:);
p4 = xyz(4:end-1,:);
p5 = xyz(5:end,:);
d23 = sqrt(sum((p2-p3).^2, 2));
d34 = sqrt(sum((p3-p4).^2, 2));
d24 = sqrt(sum((p2-p4).^2, 2));

% Calculate curvature.
dp = (d23+d34+d24)/2;
feat = 4*sqrt(dp.*max(dp-d23,0).*max(dp-d34,0).*max(dp-d24,0))./d23./d34./d24;


end