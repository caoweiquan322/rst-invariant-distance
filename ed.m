function d = ed(t, r)

if size(t, 1) ~= size(r, 1)
    t = resample(t, 60);
    r = resample(r, 60);
end
d = sqrt(sum(sum((t-r).^2)));

end