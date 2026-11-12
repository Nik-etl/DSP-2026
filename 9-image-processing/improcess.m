%% Option C: Compare Edge Detectors
% This script applies Sobel and Canny edge detectors to clean and noisy versions 
% of cameraman.tif to compare their performance and robustness to noise.

%% 1. Setup and Image Preparation
clear; close all; clc;

% Load the reference image (ships with Image Processing Toolbox)
I = imread('cameraman.tif');

% Create a noisy version with Gaussian noise
rng(42); % Set random seed for reproducibility
In = imnoise(I, 'gaussian', 0, 0.01);

% --- NEW: Simple plot for original and noisy image ---
fig_input = figure('Name', 'Original vs Noisy Image', 'Position', [100, 200, 800, 400]);
subplot(1,2,1); imshow(I); title('Original Image');
subplot(1,2,2); imshow(In); title('Noisy Image');
% -----------------------------------------------------

%% 2. Apply Edge Detectors
% Detector 1: Sobel on the image smoothed with imgaussfilt(I,1)
I_smooth = imgaussfilt(I, 1);
In_smooth = imgaussfilt(In, 1);
E1_clean = edge(I_smooth, 'Sobel');
E1_noisy = edge(In_smooth, 'Sobel');

% Detector 2: Canny with sigma = 1 (empty brackets use default thresholds)
E2_clean = edge(I, 'Canny', [], 1);
E2_noisy = edge(In, 'Canny', [], 1);

% Detector 3: Canny with sigma = 3
E3_clean = edge(I, 'Canny', [], 3);
E3_noisy = edge(In, 'Canny', [], 3);

%% 3. Visualization: Show all six edge maps in one figure
fig_edges = figure('Name', 'Edge Detection Comparison', 'Position', [100, 100, 1200, 700]);

subplot(2,3,1); imshow(E1_clean); title('Clean: Sobel (Smooth \sigma=1)');
subplot(2,3,2); imshow(E2_clean); title('Clean: Canny (\sigma=1)');
subplot(2,3,3); imshow(E3_clean); title('Clean: Canny (\sigma=3)');

subplot(2,3,4); imshow(E1_noisy); title('Noisy: Sobel (Smooth \sigma=1)');
subplot(2,3,5); imshow(E2_noisy); title('Noisy: Canny (\sigma=1)');
subplot(2,3,6); imshow(E3_noisy); title('Noisy: Canny (\sigma=3)');

%% 4. Quantitative Results: Report the number of edge pixels (nnz)
fprintf('--- Number of Edge Pixels (nnz) ---\n');
fprintf('Sobel (smooth sigma=1) | Clean: %5d | Noisy: %5d\n', nnz(E1_clean), nnz(E1_noisy));
fprintf('Canny (sigma=1)        | Clean: %5d | Noisy: %5d\n', nnz(E2_clean), nnz(E2_noisy));
fprintf('Canny (sigma=3)        | Clean: %5d | Noisy: %5d\n', nnz(E3_clean), nnz(E3_noisy));