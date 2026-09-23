%% Initial Setup
% It is best practice to start scripts by clearing old data and closing old figures
clc; 
clear; 
close all; 

%% Task 1: Create the Original Signal
t = 0 : 0.001 : 1;
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

%% Task 2: Investigate Different Sampling Frequencies
samplingFrequencies = [15, 20, 25, 50, 100]; 

figure; 
for i = 1:numel(samplingFrequencies)
    samplingFrequency = samplingFrequencies(i); 
    sampledTime = 0 : 1/samplingFrequency : 1; 
    sampledSignal = a * sin(2 * pi * f * sampledTime); 
    
    % Creates a 3x2 grid of subplots
    subplot(3, 2, i);
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

%% Task 3: Nyquist Analysis (Calculations)
fMax = f;
nyquistRate = 2 * fMax;

fprintf('\n--- Task 3: Nyquist Analysis ---\n');
fprintf('Minimum Nyquist sampling frequency: %.1f Hz\n', nyquistRate);
fprintf('Frequencies satisfying the criterion: %s Hz\n\n', ...
    mat2str(samplingFrequencies(samplingFrequencies >= nyquistRate)));

%% Tasks 3 & 4: Discussion Questions
%{
-------------------------------------------------------------------------
TASK 3 ANSWERS:
-------------------------------------------------------------------------
Is sampling exactly at the Nyquist rate recommended in practice? Explain:
No, it is not recommended. For example, in this figure, it is impossible 
to distinguish the signal when it is sampled at 20 Hz. This is because of 
the phase of the sampling. It also should not be done because there is no 
margin for error with hardware.

-------------------------------------------------------------------------
TASK 4 ANSWERS:
-------------------------------------------------------------------------
At which sampling frequencies does aliasing occur?
Aliasing occurs at all frequencies below the Nyquist rate (15 Hz in this case).

Why does aliasing occur?
Aliasing occurs because the sampling is too slow and it is unable to match 
the speed of the signal.

Which sampling frequency would you recommend for a real engineering system?
For this signal, I recommend a sampling rate in the range of 50–100 Hz 
depending on specific needs. Microcontrollers like the STM32 and ESP32 can 
handle processing requirements in this range with ease, meaning the 
computational cost remains low. This oversampling ensures much higher 
accuracy by capturing superior waveform fidelity compared to the strict 
Nyquist minimum. Finally, it provides greater robustness, making the system 
less sensitive to high-frequency noise and hardware timing errors.
-------------------------------------------------------------------------
%}