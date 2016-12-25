function xyz = rand_translate(xyz)

t = 10*randn(1, size(xyz, 2));
xyz = xyz+repmat(t, size(xyz, 1), 1);

end