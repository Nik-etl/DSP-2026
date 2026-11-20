# Image Denoising: Wiener Filter vs. AI (DnCNN)

This project compares a traditional filter (Wiener) and an AI model (DnCNN) for removing noise from a grayscale image in MATLAB.

![Denoising Comparison](images/comparison.png)

## Sections

### 1. Setup & Adding Noise
Loaded `cameraman.tif` and added random Gaussian noise (`sigma = 0.04`) to make the image grainy.

### 2. Traditional Filter (Wiener)
Used `wiener2` to smooth out the noise. It blurs flat areas strongly while trying to keep edges sharp.

### 3. AI Filter (DnCNN)
Used MATLAB's built-in `DnCNN` neural network (`denoiseImage`) to automatically clean the noise while keeping fine details.

### 4. Quality Scores (PSNR & SSIM)
Measured how close each denoised image is to the original (higher numbers mean better quality):


| Image / Method | PSNR (dB) | SSIM |
| :--- | :---: | :---: |
| **Noisy Image** | `~28.13` | `~0.63` |
| **Traditional (Wiener)** | `~32.13` | `0.88` |
| **AI (DnCNN)** | `~32.64` | `~0.89` |


### 5. Visual Comparison
The Wiener filter removes most of the noise but makes small details slightly blurry. The **AI (DnCNN)** filter gives the best visual result and highest scores, removing grain while keeping edges and textures sharp.

## AI Usage

* **Tool used: Claude (Anthropic)**
* **How I used it: I used it to explain the the filter tools and format a readme template.**