## A RST-invariant distance measure for 2d/3d trajectories

The RST represnets Rotation, Scaling, Translation, respectively.

## The background rationality.

The RST-invariant measure consists of 4 phases:

* Filtering phase to remove outliers.
* Normalization phase to make the 2d/3d trajectory of zero mean and of comparable scale, where the translation and scaling effects will be removed.
* Rotation estimation phase to rotate traj_b to match traj_a best.
* Distance calculation phase to finally calculate the distance by ED/DTW/LCSS etc.

## Author

Weiquan Cao.