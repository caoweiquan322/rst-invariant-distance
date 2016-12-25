function xyz = rand_rotate(xyz)

R = orth(rand(size(xyz, 2)));
xyz = xyz*R;

end