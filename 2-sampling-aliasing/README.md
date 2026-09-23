# Lecture 02 – Sampling and Aliasing

 ## Objective

 The purpose of this assignment was to familiarize ourselves with sampling and the Nyquist theorem.

 ## Nyquist Analysis

 The max frequency was given as 10Hz: 2 * 10Hz = 20Hz. 20Hz is the nyquist rate however a sampling rate higher should be used for better accuracy.

 ## Results

15Hz was far too slow to catch the signal, 20Hz was in phase with the signal and only displayed 0, 25Hz was still too slow to accurately depict the signal, 50Hz was able to display a distinguishable signal through visualization, and 100Hz displayed an easily recognizable signal.

 ## Aliasing Discussion

 Aliasing occurs at all frequencies below the Nyquist rate (15 Hz in this case). Aliasing occurs because the sampling is too slow and it is unable to match the speed of the signal.

 ## Engineering Recommendation

 For this signal, I recommend a sampling rate in the range of 50–100 Hz 
depending on specific needs. Microcontrollers like the STM32 and ESP32 can 
handle processing requirements in this range with ease, meaning the 
computational cost remains low. This oversampling ensures much higher 
accuracy by capturing superior waveform fidelity compared to the strict 
Nyquist minimum. Finally, it provides greater robustness, making the system 
less sensitive to high-frequency noise and hardware timing errors.

 ## AI Usage

Google's Gemini

- Prompt(s)
"Clean this code up: 
```matlab


    % It is best practice to start scripts by clearing old data and closing old figures

    clc;

    clear;

    close all;

    %%%Tasks

    %

    %Task 1 – Create the Original Signal (15 points)

    %

    %Generate a 10 Hz sine wave with a duration of 1 second using a sufficiently small time step so that it closely represents a continuous-time signal.

    t = 0 :0.001 : 1;

    f = 10;

    a = 1;

    originalsignal = a * sin(2 * pi * f * t);

    figure;

    plot(t, originalsignal, 'LineWidth', 1.5);

    title('Original 10 Hz Sine Wave');

    xlabel('Time (s)');

    ylabel('Amplitude');

    grid on;

    legend('Original signal');

    saveas(gcf, 'original_signal.png');

    %Plot the signal with appropriate:

    %

    %title,

    %axis labels,

    %grid,

    %legend (if applicable).

    % Save the figure as:

    %

    % original_signal.png

    %%Task 2 – Investigate Different Sampling Frequencies (35 points)

    %

    % Sample the same signal using the following sampling frequencies:

    %

    % 15 Hz

    samplingFrequencies = [15, 20, 25, 50, 100];

    figure;

    for i = 1:numel(samplingFrequencies)

    samplingFrequency = samplingFrequencies(i);

    sampledTime = 0 : 1/samplingFrequency : 1;

    sampledSignal = a * sin(2 * pi * f * sampledTime);


    % Creates a 3x2 grid of subplots

    subplot(3, 2, i);

    % figure(i + 1)

    plot(t, originalsignal, 'LineWidth', 1.2);

    hold on;

    stem(sampledTime, sampledSignal, 'filled', 'MarkerSize', 4);

    hold off; % Good practice to turn off hold


    title(sprintf('%d Hz Sampling', samplingFrequency));

    xlabel('Time (s)');

    ylabel('Amplitude');

    grid on;

    legend('Original', 'Samples', 'Location', 'best'); % Optimizes legend placement

    end

    % 20 Hz

    % 25 Hz

    % 50 Hz

    % 100 Hz

    % For each sampling frequency:

    %

    % plot the original continuous signal,

    % overlay the sampled points using markers or stems,

    % compare the sampled representation with the original signal.

    % Create one figure with five subplots (recommended) or five separate figures.

    %

    % If using separate figures, save them as:

    %

    % sampling_15Hz.png

    %

    % sampling_20Hz.png

    %

    % sampling_25Hz.png

    %

    % sampling_50Hz.png

    %

    % sampling_100Hz.png

    %

    % Task 3 – Nyquist Analysis (15 points)

    %

    % The original signal has a frequency of: fmax = 10 Hz

    fMax = f;

    nyquistRate = 2 * fMax;

    fprintf('Minimum Nyquist sampling frequency: %.1f Hz\n', nyquistRate);

    fprintf('Frequencies satisfying the criterion: %s Hz\n', ...

    mat2str(samplingFrequencies(samplingFrequencies >= nyquistRate)));

    %

    % Determine the minimum sampling frequency using the Nyquist Sampling Theorem.

    %

    % Show your calculation.

    %

    % Then answer:

    %

    % Which sampling frequencies satisfy the Nyquist criterion?

    % Is sampling exactly at the Nyquist rate recommended in practice? Explain your answer.

    % No it is not recommended for example in this figure it is impossible

    % to distinguish signal when it is sampled at 20 Hz. This is because of

    % the phase of the sampling. It also should not be done because there

    % is no margin for error with hardware.

    % Task 4 – Aliasing Discussion (20 points)

    % At which sampling frequencies does aliasing occur?

    % Aliasing occurs at all frequencies below the Nyquist rate

    % Why does aliasing occur?

    % Aliasing occurs because the sampling is too slow and it is unable to match the speed of the signal.

    % Which sampling frequency would you recommend for a real engineering system?

    % For this signal, I recommend a sampling rate in the range of 50–100 Hz depending on specific needs. Microcontrollers like the STM32 and ESP32 can handle processing requirements in this range with ease, meaning the computational cost remains low. This oversampling ensures much higher accuracy by capturing superior waveform fidelity compared to the strict Nyquist minimum. Finally, it provides greater robustness, making the system less sensitive to high-frequency noise and hardware timing errors. 
    ```
- Summary of AI Response
    cleaned up code
- What I Modified
    removed unnecessary comments
- How I Verified the Results
    I reran the code and verified nothing structurally was changed