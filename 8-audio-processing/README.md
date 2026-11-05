# DSP Assignment - Option C: Analyse an environmental sound

## Selected Option
**Option C** — Analyse an environmental sound

## Audio Filename
- Dog recording (loaded dynamically from the supplied `manifest.csv` dataset)

## Settings Used
- **Sample Rate:** 16,000 Hz (16 kHz)
- **Hop Length:** 160 samples
- **Spectrogram Window Lengths (N_FFT):** 512 samples and 2048 samples

## Instructions for Running the Notebook
1. Open `analysis.ipynb` in Google Colab or your preferred Jupyter environment.
2. Run the first setup cell to install all required dependencies (PyTorch, librosa, etc.). 
3. **Important:** Restart the runtime when prompted by the output of the first cell.
4. Run the second cell and upload the `Audio_Course_Package.zip` file when prompted to load the dataset.
5. Execute the remaining cells in sequence to load the audio, plot the waveform and spectrum, and generate the spectrogram comparisons.
6. The final output files (figures and CSVs) will be saved in the generated `results/` archive.

## Main Conclusion
The analysis of the dog bark reveals a clear trade-off between time and frequency resolution based on window length. The primary bark occurs between **2.0 and 2.5 seconds**, with the highest concentration of energy lying roughly between **900 Hz and 2000 Hz**. 
* The **512-sample window** offers superior **time resolution**, meaning sharp transient sounds (like the sudden rise of the bark) appear as vertical lines without blurring across the time axis. However, its frequency resolution is lower.
* The **2048-sample window** provides better **frequency resolution**, revealing clearer horizontal frequency bands and harmonics. The trade-off is that it smears these transient sounds across time, resulting in a loss of sharp timing precision.

## Limitation
This analysis investigates only a single recording. The temporal patterns, frequency concentrations, and harmonic structures observed here are specific to this particular dog and its acoustic environment, and may not generalize to other dog barks.

## AI Usage

* **Tool used: Claude (Anthropic)**
* **How I used it: I used it to draft the python cells, debug library issues, as well as format and provide a readme template.**
* **What I verified or changed: I verified the figures and logic matched similar results in the class example**