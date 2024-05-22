# CS270-Digital-Image-Processing
This repository contains [homework](https://github.com/wangyf9/CS270-Digital-Image-Processing/tree/main/HW) and [ppt](https://github.com/wangyf9/CS270-Digital-Image-Processing/tree/main/ppt) and [Final_PJ] of the CS270 course, spring, 2024 in Shanghaitech.

## Homework

- HW1 
  - Q1: Histogram Equalization
    - Implement Histogram Equalization(HE) and contrast limited adaptive histogram equalization(ALAHE)
  - Q2: Image Sharpening
    - Sharpen the image by using the 1D and 2D Laplacian kernels respectively
    - Use unsharpen mask to sharpen the image
  - Q3: Nonlinear Filter
    - Apply the median filter and Gaussian filter to the image, decreasing the noise
- HW2
  - Q1: Image Sharpening
    - Apply separable 3 × 3 Sobel kernels to extract the feature in image in two directions
    - Implement Gaussian Highpass filtering to extract the high frequency information
  - Q2: Homomorphic filtering
    - Implement Homomorphic filtering process and its related filter, finding appropriate parameters
  - Q3: Color Space Conversion
    - Convert RGB image to HSI color space
    - Convert HSI image back to RGB color space
  - Q4: Image Restoration
    - Restore an image with a motion blur
    - Show the frequency domain of the image
    - Use Radon Transform to find the rotation, $\theta$
    - Use the vertical projection to find the peak and then estimate $L$
    - Apply Wiener filtering with the estimated parameters to restore the image, finding appropriate parameter for it
- HW3
  - Q1: CT reconstruction
    - Ramp filter with a hamming window
  - Q2: Thresholding
    - Basic Global thresholding: split into two groups and calculate the new $\mu$ to get the updated $T$ 
    - Region split and merge algorithm: padding first to get the square image so that it can directly use quadtree decomposition, and then we can use quadtree synthesis to merge regions that meet the conditions
  - Q3: Super pixel
    - Convert to lab color space, and then calculate the corresponding parameters given cluster numbers and `M` compactness coefficient
    - Execute alike K-means algorithm to reassign points to different cluster centroids with a specific label