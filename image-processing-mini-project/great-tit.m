%% Lab 6: Mini Project – Your Image Pipeline
close all; clear; clc;

%% 1) Load your own image (object, face, landscape, etc.)
I_rgb = im2double(imread('great-tit-2.jpeg'));
I_rgb = rot90(I_rgb, -1); % -1 = 90° clockwise (1 = 90° counterclockwise)

% column row width height
rect = [520, 1500, 2200, 1700];
I_rgb = imcrop(I_rgb, rect); % crop

I_gray = rgb2gray(I_rgb);
figure;
imhist(I_gray);
title('Grayscale Histogram');

figure;
imshow(I_gray, 'InitialMagnification', 100); % 1 image pixel = 1 screen pixel
title('Cropped Grayscale');

% RGB components
R = I_rgb(:,:,1); % Red channel
G = I_rgb(:,:,2); % Green channel
B = I_rgb(:,:,3); % Blue channel

figure;
montage({R, G, B}, 'Size', [1 3]);
title('Red | Green | Blue');

%% CHANGE TO FIND WHICH COLOR
I_cropped = G; % R appears to work best

%% 2) Pre-process: noise removal (all 3 channels)
R_filt = medfilt2(R, [3 3]);
G_filt = medfilt2(G, [3 3]);
B_filt = medfilt2(B, [3 3]);

figure; 
imshow(G_filt, 'InitialMagnification', 100); % 1 image pixel = 1 screen pixel
title('filter (Green channel preview)');

%% 3) Enhance contrast (all 3 channels)
R_enh = imadjust(R_filt, [0.2 0.8], [0 1], 1.4); % R and G display head edges much better
G_enh = imadjust(G_filt, [0.2 0.8], [0 1], 1.4);
B_enh = imadjust(B_filt, [0.2 0.8], [0 1], 1.4); % B displays back and body edges better

figure; 
imshow(B_enh, 'InitialMagnification', 100); % 1 image pixel = 1 screen pixel
title('contrast (Green channel preview)');
I_enh = B_enh;

%% edges in one
 % Extract features (combine R, G, B edges + morphological cleanup)
 edges_R = edge(R_enh, 'Canny', [0.08 0.2], 2.5);
 edges_G = edge(G_enh, 'Canny', [0.08 0.2], 2.5);
 edges_B = edge(B_enh, 'Canny', [0.08 0.2], 2.5);
 
 % Combine edges found in ANY of the three channels
 edges = edges_R | edges_G | edges_B;
 
 edges_clean = imclose(edges, strel('disk', 5));       % bridges edge gaps in bird
 edges_clean = bwareaopen(edges_clean, 950);          % removes tiny stray specs
 
 figure; 
 imshow(edges_clean, 'InitialMagnification', 100);
 title('Combined RGB Closed & Cleaned Outline');

 % --- Method B: Region-based (Multi-Level Otsu Segmentation) ---
 thresh = multithresh(B_enh, 2);       % Finds 2 Otsu thresholds: [dark_cutoff, bright_cutoff]
 dark_parts   = R_enh < thresh(1);     % Captures bird's black cap & bib R captures head better
 bright_parts = B_enh > thresh(2);     % Captures bird's white cheek & bright chest B 

 bird_mask = imclose(dark_parts | bright_parts, strel('disk', 6)); % Connects dark head & bright chest
 bird_mask = bwareaopen(bird_mask, 850);                           % Removes small stray blobs
 otsu_outline = bwperim(bird_mask);                                % Extracts 1-pixel outline of the mask

 figure;
 montage({dark_parts, bright_parts}, 'Size', [1 2]);
 title('Otsu Dark | Otsu Bright |');

 figure;
 montage({edges_clean, bright_parts}, 'Size', [1 2]);
 title('Canny edge detection | Otsu Bright |');
edges_clean = edges_clean | bright_parts; %| dark_parts;
 figure;
 imshow(edges_clean, 'InitialMagnification', 100);
 title('combination');

%% 4) Extract features (optimize R, G, B separately, then combine)
se = strel('disk', 6);

% imclose bridges edge gaps in bird - Expands white edge lines by 6 pixels and then shaving off pixels that do not happen to touch other pixels
% bwareaopen Removes tiny stray specs - evaluates connected white pixels if a group has less than 150 connected, it removes that group

% % --- Red channel (strong chest & cheek contrast) ---
% edges_R = edge(R_enh, 'Canny', [0.08 0.20], 2.5);
% clean_R = bwareaopen(imclose(edges_R, se), 150);
% 
% % --- Green channel (balanced overall structure) ---
% edges_G = edge(G_enh, 'Canny', [0.08 0.20], 2.5);
% clean_G = bwareaopen(imclose(edges_G, se), 850);
% 
% % --- Blue channel (strongest separation on yellow chest, slightly noisier) ---
% edges_B = edge(B_enh, 'Canny', [0.10 0.25], 2.5);
% clean_B = bwareaopen(imclose(edges_B, se), 1000);
% 
% % Combine the cleaned outlines from all three channels
% edges_clean = clean_R | clean_G | clean_B;
% 
% figure; 
% montage({clean_R, clean_G, clean_B, edges_clean}, 'Size', [1 4]);
% title('Clean R | Clean G | Clean B | Combined Outline');
%% 5) Optional frequency-domain mask
F = fftshift(fft2(I_enh));
[M, N] = size(F);
[u, v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
H = double(sqrt(u.^2 + v.^2) < 60);
I_lp = real(ifft2(ifftshift(F .* H)));

figure; 
imshow(I_lp, 'InitialMagnification', 100);
title('low pass filter');

%% 6) Visualization
figure; 
montage({I_cropped, I_filt, I_enh, edges_clean, I_lp}, 'Size', [1 5]);
title('Cropped | Denoised | Enhanced | Cleaned Edges | LP result');

%% 7) Report
% Problem: The bird (a Great Tit) can be hard to see behind branches and pine needles. The goal is to isolate and detect the bird's outline and body.
% - Describe your processing pipeline.
The original image was taken through binoculars and had circular outline with the outside containing nothing but black pixels, This would skew the histogram vastly so I had to crop the image to focus on the important signals. the image then goes through a simple 2d 3x3 median filter to remove any jpeg compression and camera sensor noise. 
% - Explain how each stage relates to DSP operations.
% - Discuss improvements or limitations.