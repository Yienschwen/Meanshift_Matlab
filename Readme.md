# Meanshift_Matlab

A naive sequential implementation of mean shift algorithm along with several helper functions.

You may also use your custom defined neighbor function and kernel function to calculate center of each intermediate cluster. See documentation in function `Meanshift` for more details.

Use the `MSDemo` script to run a demo.

## Functions
1. `Meanshift`: Move all data points to the center of their mean shift cluster.
2. `BallCluster`: Output the cluster index of each clustered data points.

## Helper functions

1. `Img2Ary`: Convert an image (HxWx3) into a row of pixel columns (3x(HW))
2. `Ary2Img`: Convert a row of pixel columns back to an image of given size
3. `VecNorm2Sq`: Calculate squared l-2 norm of each data column lined in a row. Equivalent offical implementation is provided in version `2017b`. 

## References
1. [`MeanShift_py` by mattnedrich](https://github.com/mattnedrich/MeanShift_py), along with `test.jpg` taken from that repo.