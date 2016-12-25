function xyz = resample(xyz, N)

% Re-sampling.
x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);
acc_len = cumsum(sqrt(diff(x).^2 + diff(y).^2 + diff(z).^2));
if size(acc_len, 1) == 1
    acc_len = [0, acc_len];
else
    acc_len = [0; acc_len];
end
nx = zeros(N, 1); ny = zeros(N, 1); nz = zeros(N, 1);
nx(1) = x(1); ny(1) = y(1); nz(1) = z(1);
nx(end) = x(end); ny(end) = y(end); nz(end) = z(end);
step = acc_len(end)/(N-1);
j = 2;
for i=2:N-1
    pos = (i-1)*step;
    while acc_len(j) < pos, j=j+1; end
    u = (pos-acc_len(j-1))/(acc_len(j)-acc_len(j-1));
    v = 1-u;
    nx(i) = u*x(j)+v*x(j-1);
    ny(i) = u*y(j)+v*y(j-1);
    nz(i) = u*z(j)+v*z(j-1);
end
xyz = [nx, ny, nz];

end