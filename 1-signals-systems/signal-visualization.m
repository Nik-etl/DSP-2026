%% Initial Setup
% It is best practice to start scripts by clearing old data and closing old figures
clc; 
clear; 
close all; 

%% Task 1: Create a Sine Wave
t = 0 : 0.001 : 1; % Excellent choice on the time step!
w1 = sin(2*pi*5*t);

figure; % Opens a new window so Task 2 doesn't overwrite this plot
plot(t, w1);
% You had the comments for these, but missed the actual commands!
title('Task 1: 5 Hz Sine Wave');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on; 

%% Task 2: Compare Different Frequencies
frequencies = [2, 5, 10];
for i = 1:length(frequencies)
    subplot(3,1,i)
    plot(t, sin(2*pi*frequencies(i)*t))
    title([num2str(frequencies(i)), ' Hz']);
end
%% Task 3: Compare Different Amplitudes
% Using 2 Hz for all signals as you originally set up
amplitudes = [0.5, 1.0, 2.0];
for i = 1:length(amplitudes)
    subplot(3,1,i)
    plot(t, amplitudes(i) * sin(2*pi*2*t))
    ylim([-2.5 2.5]);
    title(['Amplitude: ', num2str(amplitudes(i))]);
end
%% Task 4: Add Noise
f = 2;
cleansignal = sin(2*pi*f*t);
noise = 0.1 * randn(size(t));
noisysignal = cleansignal + noise;

figure; % Opens a fourth window
plot(t, noisysignal);
title('Task 4: Noisy Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;