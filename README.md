# Fast-energy-minimization-for-stereo
Fast energy minimization for stereo problem in computer vision via graph cut.
 In two-view stereo, we need to find the disparity map for the input images. This problem can be formulated in terms of energy minimization. 
 
 
There are generally two types of methods to minimize this energy. First one is to find the global minimum, but it’s very slow. Second one is to find the local minimum, but the local minimum might be very far away from the global minimum. I'm using graph-cut-based a-expansion algorithm to find the local minimum. Not only this method is fast, but also the local minimum it find is proved to be within a known factor of the global optimum.
    Input :
    Two images taken from different viewpoints for stereo
    Output:
    A new image containing the disparity information for the first image
