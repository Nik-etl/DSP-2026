Compare edge detectors
Use cameraman.tif. Create a noisy version: rng(42); In = imnoise(I,'gaussian',0,0.01);
Apply three detectors to both the clean and the noisy image: Sobel on the image smoothed with imgaussfilt(I,1), Canny with sigma 1, and Canny with sigma 3. Keep the default thresholds.
Show all six edge maps in one figure. Report the number of edge pixels (nnz) for each result.
Explain the effect of sigma and of smoothing on false edges in the noisy image. Identify one region where an edge is lost or invented. Describe one limitation: the edge-pixel count does not measure correctness.