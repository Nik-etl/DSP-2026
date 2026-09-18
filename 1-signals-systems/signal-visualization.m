% Task 1: Create a Sine Wave
%Generate a sine wave in MATLAB.
%
%Requirements:
%
%Amplitude = 1
%Frequency = 5 Hz
%Duration = 1 second

t = 0 : 0.001 : 1; % if sampling rate is the same as frequency readings will show a straight line. sampling has to be much faster
w1 = sin(2*pi*5*t);

%Create a plot with:
%
%Title
%X-axis label
%Y-axis label
%Grid enabled

plot(t, w1)
%%
% Task 2: Compare Different Frequencies
%
%Generate three sine waves:
%
%2 Hz
%5 Hz
%10 Hz

w2 = sin(2*pi*2*t);
w3 = sin(2*pi*10*t);

%Display them using subplots.

subplot(3,1,1)
plot(t,w2)
title("2Hz")

subplot(3,1,2);
plot(t,w1)
title("5Hz")

subplot(3,1,3);
plot(t,w3)
title("10Hz")
%
%Answer these questions in your README:
%
%Which signal changes fastest?
%Which signal has the lowest frequency?
%How can you see the difference in the plots?

%%
%Task 3: Compare Different Amplitudes
%
%Generate three sine waves with amplitudes:
%
%0.5
%1
%2
%Use the same frequency for all signals.
%
%Display them using subplots.

w4 = 0.5 *sin(2*pi*2*t);
w5 = sin(2*pi*2*t);
w6 = 2 *sin(2*pi*2*t);

subplot(3,1,1)
plot(t,w4)
ylim([-2 2])
title("Amplitude 0.5")

subplot(3,1,2);
plot(t,w5)
ylim([-2 2])
title("Amplitude 1")

subplot(3,1,3);
plot(t,w6)
ylim([-2 2])
title("Amplitude 2")
%
%Answer these questions in your README:
%
%Which signal has the largest amplitude?
%Does changing amplitude change frequency?
%Give one real-world example where amplitude is important.
% Task 4: Add Noise
%
%Generate a clean sine wave.
%
%Add random noise to create a noisy signal.
%
%Display:
%
%Clean signal
%Noisy signal
%using subplots.
%
%Answer these questions in your README:
%
%What changed after adding noise?
%Can you still recognize the original signal?
%Give one real-world source of signal noise.
%Task 5: Save Figures
%
%Save the following figures as PNG files:
%
%frequency_comparison.png
%
%amplitude_comparison.png
%
%clean_vs_noisy_signal.png
%
% Task 6: Use AI Responsibly
%
%You may use:
%
%ChatGPT
%GitHub Copilot
%Claude
%Gemini
%Other AI assistants
%Ask AI for help with one MATLAB task.
%
%Include the following in your README:
%
%AI Tool Used:
%
% Prompt:
%
% What AI Suggested:
%
% Did the code work immediately?
%
% What did you modify?
%
% How did you verify the result?
%
%Remember:
%
%AI is allowed. Verification is mandatory.
%
% GitHub Submission
%
%Create the folder:
%
%Lecture01
%
%Upload:
%
%Lecture01_signal_visualization.m
%
%README.md
%
% frequency_comparison.png
%
%amplitude_comparison.png
%
%clean_vs_noisy_signal.png
%
% Submit to Moodle
