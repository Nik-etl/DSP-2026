# MATLAB Exercises on Fourier Series, DTFT and DFT

## Exercise 1: Build a Square Wave from Harmonics

**1. Prediction (Before running MATLAB):**
*What will happen to the waveform as you add more harmonics?*
[Insert your prediction here]

**4. Description of changes:**
*What changes as H increases?*
[Insert your description here]

**5. Observation near sharp transitions:**
*What do you observe close to the sharp transitions of the square wave?*
[Insert your observation here]

---

## Exercise 2: Find Two Frequencies with the FFT

**1. Frequencies and Amplitudes Prediction:**
*What are the two frequencies and their amplitudes?*
[Insert your predicted frequencies and amplitudes here]

**4. Peak Identification and Comparison:**
*Identify the two peaks. Compare their frequencies and amplitudes with the original signal values.*
[Insert your comparison here]

**5. Bin-Spacing Calculation:**
*Calculate the frequency-bin spacing using fs and the number of samples. Compare expected and measured values.*
* **Expected bin spacing:** [Calculation/Value]
* **Measured bin spacing:** [Value from plot]
* **Comparison:** [Insert comparison here]

---

## Exercise 3: Investigate Spectral Leakage

**Variables used:**
* **Digit `d`:** [Insert your digit (0-9)]
* **Calculated `f2`:** [Insert calculated f2 value]

**1. Prediction (Before running MATLAB):**
*What will happen to the peak at f2?*
[Insert your prediction here]

**4. 1-Second vs 4-Second Recording Comparison:**
*Compare the spectra. Explain how the bin spacing and the appearance of the peak change.*
[Insert your explanation here]

**5. Zero-Padding Analysis:**
*What looks different in the zero-padded plot? Does the original recording contain more information?*
[Insert your explanation here]

---

## Exercise 4: Compare the DTFT and DFT

**4. DTFT vs DFT Comparison:**
*Compare the smooth DTFT curve with the DFT values.*
[Insert your comparison here]

**5. FFT Point Size Explanation:**
*Explain why `fft(x,64)` produces more frequency points than `fft(x,4)`. Does it add new samples to the original sequence?*
[Insert your explanation here]

**6. Zero Magnitude Identification:**
*From the DTFT plot, identify where the magnitude becomes zero.*
[Insert your identification here]

---

## AI Usage

* **Tool used:** Gemini
* **How I used it:** I used it to format my readme
* **What I verified or changed:** 