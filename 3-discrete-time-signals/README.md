### Assignment Questions

**1. Which operation changed the signal amplitude?**
Amplitude scaling changed the signal's amplitude. Multiplying the signal by a constant factor scales the signal, which changes its amplitude.

**2. How did the five-sample delay change the signal?**
The delay shifted the entire signal so that it occurs later in time. By adding 5 zeros to the beginning of the array, the delay changes when the signal occurs. 

**3. What does the impulse response represent?**
The impulse response describes a digital system. It dictates the system's behavior; for example, a smoothing averages neighboring samples to filter a signal.

**4. How did convolution change the noisy signal?**
Convolution calculates the output from the input and the impulse response. In this case, convolution moved the filter across the input sequence, replacing each sample with a local average of neighboring values, which successfully reduced the rapid random variations and smoothed out the noise.

**5. What differences did you observe between the 5-point and 15-point filters?**
The 5-point filter provided moderate smoothing, reducing some noise while closely tracking the shape of the original sine wave. The 15-point filter created a much smoother line but visibly flattened the peaks and valleys of the sine wave compared to the clean signal.

**6. Which filter removed more noise?**
The 15-point filter removed more high-frequency noise because it averaged data over a much wider window of samples.

**7. Did the longer filter remove or distort useful signal information?**
Yes, the 15-point filter distorted the useful signal information. Excessive smoothing from the longer moving-average filter reduced the signal's true amplitude and removed useful signal details at the peaks and troughs.

**8. Which filter would you recommend for this signal? Explain your decision.**
I would recommend the 5-point filter. While the 15-point filter eliminates more noise, it introduces too much distortion by reducing the amplitude of the underlying sine wave. The 5-point filter strikes a better balance between reducing random noise and preserving the true shape and amplitude of the original clean signal. 

**9. Give one real engineering application for moving-average filtering.**
A real engineering application is smoothing noisy sensor readings, such as filtering fluctuating analog readings from an IoT temperature sensor to obtain a stable, accurate digital measurement.

### AI Usage

**Tool used:** Gemini
**How I used it:** I used it to help write optimized code and I verified it by making sure it ran and outputted the same