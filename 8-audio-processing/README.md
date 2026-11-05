# DSP Audio Experiment Assignment

## Selected Option

**Option C — Analyse an environmental sound**

## Audio Filenames

*The following supplied audio file was used in this experiment:*

* **\[Insert filename here, e.g., dog_bark_01.wav\]** *(Note: Choose from the supplied dog, rain, fire, or clock-tick recordings).*
  
*(Note: The complete dataset is not included in this repository. Please refer to the supplied assignment files.)*

## Settings Used

* **Audio Sample Rate:** 16 kHz
* **Hop Size:** 160 samples
* **Window Lengths Compared:** 512 samples and 2048 samples
* **Other relevant parameters:** \[List any other specific settings, e.g., FFT size, window type like Hann\]

## Instructions for Running the Notebook

1. Clone this repository.
2. Ensure you have the required dependencies installed: `[List dependencies, e.g., numpy, librosa, matplotlib]`.
3. Place the original supplied audio file in the `[Insert folder name, e.g., data/]` directory.
4. Open and run `analysis.ipynb` sequentially from top to bottom.
5. The generated waveform, frequency spectrum, and comparative spectrograms will be saved in the `results/` folder.

## Main Conclusion

**\[Summarize your findings in 2-3 sentences based on your analysis.\]**
*Example: The comparison demonstrated the trade-off between time and frequency resolution. The 512-sample window provided better time resolution, clearly showing the sharp transients of the \[e.g., dog bark\] at \[insert time interval\], while the 2048-sample window provided better frequency resolution, highlighting the harmonic structure in the \[insert frequency region\] range.*

## Limitations

**\[State one limitation of your analysis as required by the brief.\]**
*Example: One limitation of this analysis is that it relies on a fixed hop size of 160 samples, which might not be optimally tuned for both window sizes, potentially affecting the smoothness of the resulting spectrograms...*

## AI Tools Usage

**\[Briefly state how you used AI assistance for this assignment.\]**
*Example: I used Gemini to help draft the README file and to assist with the matplotlib syntax for plotting the side-by-side spectrograms. All code was run and verified by me.*