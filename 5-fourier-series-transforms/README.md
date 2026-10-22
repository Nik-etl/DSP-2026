# MATLAB Exercises on Fourier Series, DTFT and DFT

## Exercise 1: Build a Square Wave from Harmonics

**1. Prediction (Before running MATLAB):**
*What will happen to the waveform as you add more harmonics?*
I predict it will grow closer to a square wave.

**4. Description of changes:**
*What changes as H increases?*
The signal approximates the shape of a square wave, with the rising and falling edges becoming much steeper as more high-frequency sinusoidal components are added.

**5. Observation near sharp transitions:**
*What do you observe close to the sharp transitions of the square wave?*
There are sharp spikes rising above the square wave, this is because with a finite sum of harmonics it is impossible to create a non-continuous step function (this is known as the Gibbs phenomenon).

---

## Exercise 2: Find Two Frequencies with the FFT

**1. Frequencies and Amplitudes Prediction:**
*What are the two frequencies and their amplitudes?*
15 Hz at 0.8 amplitude and 40 Hz at 0.4 amplitude.

**4. Peak Identification and Comparison:**
*Identify the two peaks. Compare their frequencies and amplitudes with the original signal values.*
There is a 0.8 amplitude peak at exactly 15 Hz and a 0.4 amplitude peak at exactly 40 Hz. The measured values match the original signal parameters perfectly.

**5. Bin-Spacing Calculation:**
*Calculate the frequency-bin spacing using fs and the number of samples. Compare expected and measured values.*
- **Expected bin spacing:** 1 Hz (Calculated as fs / N = 200 / 200)
- **Measured bin spacing:** 1 Hz
- **Comparison:** Measured and expected bin spacing are matching.

---

## Exercise 3: Investigate Spectral Leakage

**Variables used:**
- **Digit `d`:** 4
- **Calculated `f2`:** 13.88 Hz (calculated as 13.2 + 0.17 * 4)

**1. Prediction (Before running MATLAB):**
*What will happen to the peak at f2?*
Because 13.88 Hz does not complete an integer number of cycles in the 1-second recording window, I predict the energy will leak into adjacent frequency bins, causing the peak to appear wider and shorter than its true 0.4 amplitude.

**4. 1-Second vs 4-Second Recording Comparison:**
*Compare the spectra. Explain how the bin spacing and the appearance of the peak change.*
The 1-second recording has a frequency bin spacing of 1 Hz, which causes severe spectral leakage for the 13.88 Hz frequency. By increasing the recording to 4 seconds, the number of samples increases, narrowing the bin spacing to 0.25 Hz. This allows the peak to be captured much more sharply and closer to its true amplitude.

**5. Zero-Padding Analysis:**
*What looks different in the zero-padded plot? Does the original recording contain more information?*
The zero-padded plot creates a smoother-looking curve because it adds more frequency data points between the bins (interpolating the spectrum). However, the original recording does not contain more information; zero-padding simply pads the sequence with zeros to sample the existing spectrum at a higher density without actually increasing the true frequency resolution.

---

## Exercise 4: Compare the DTFT and DFT

**4. DTFT vs DFT Comparison:**
*Compare the smooth DTFT curve with the DFT values.*
Because computers process discrete samples rather than continuous signals, the DFT evaluates frequencies at discrete intervals. The calculated DFT magnitude points fall exactly on top of the smooth, continuous DTFT curve. 

**5. FFT Point Size Explanation:**
*Explain why `fft(x,64)` produces more frequency points than `fft(x,4)`. Does it add new samples to the original sequence?*
`fft(x,64)` produces more frequency points because it mathematically pads the original 4-sample sequence with 60 trailing zeros before computing the transform. It does not add new physical information or actual sampled data to the original sequence.

**6. Zero Magnitude Identification:**
*From the DTFT plot, identify where the magnitude becomes zero.*
The magnitude becomes exactly zero at angular frequencies $w = \pm \pi / 2$ and $w = \pm \pi$.

---

## AI Usage

- **Tool used:** Gemini
- **How I used it:** I used it to format my readme and verify my understanding of zero-padding and DTFT behaviors.
- **What I verified or changed:** I verified that zero-padding does not increase actual frequency resolution before writing the final answers for Exercise 3 and 4.