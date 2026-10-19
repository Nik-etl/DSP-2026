# Assignment 4: Z-Transform and System Analysis

## README Questions

**1. The Delay Operator:** 
What does the $z^{-1}$ operator represent in your digital filter equation?
It represents the time delay of components in the equation

**2. Convolution vs. Multiplication:** 
How does analyzing the transfer function $Y(z) = X(z)H(z)$ simplify the process of calculating a system's output compared to time-domain convolution?
It allows for analyzing using simple algebra instead of more complex and time consuming methods in the time domain

**3. Poles and Stability:** 
Based on your generated `zplane` figure, what is the exact location of the pole? Does this pole location indicate that the system is stable or unstable?
The exact location of the pole is at $z = 0.5$[cite: 1]. This pole location indicates that the system is stable because it is situated inside the unit circle[cite: 1].

**4. Impulse Response:** 
When analyzing the `impz` output, does the response decay or grow over time? How does this visually confirm your stability assessment?
The impulse response decays over time, with the output values progressively shrinking[cite: 1]. This visually confirms the stability assessment because a stable system's output will naturally fade rather than grow indefinitely[cite: 1].

**5. Frequency Response:** 
Based on your `freqz` plot, does this filter pass slow changes or rapid fluctuations more strongly?
This filter passes slow changes strongly while actively reducing rapid fluctuations[cite: 1].

**6. Filter Memory:** 
When modifying the feedback coefficient ($\alpha$) in your MATLAB experiment, how did a larger coefficient alter the filter's memory and response speed?
A larger feedback coefficient gives the filter more memory, which results in a slower response speed[cite: 1].

---

## AI Usage

- **Tool used:** *Gemini*
- **How I used it:** I used it to help format my readme, and check my understanding of poles, stability, and frequency response.
- **What I verified or changed:** I verified the theoretical pole location and the relationship between the feedback coefficient and response speed against my MATLAB plots before writing the final answers.