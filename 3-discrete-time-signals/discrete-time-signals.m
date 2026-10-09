clear;
close all;
clc;

% Use the same random noise each time
rng(1);

%% Create a clean discrete-time signal
n = 0:100;
clean = sin(0.1*pi*n);

%% Add noise
noise = 0.4*randn(size(n));
measured = clean + noise;

%% Task 1: Amplitude Scaling
scaled = 2 * measured; % Multiply the noisy signal by 2

figure;
plot(n, measured, 'Color', [0.6 0.6 0.6], 'LineWidth', 1.5);
hold on;
plot(n, scaled, 'b', 'LineWidth', 1.5);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Task 1: Discrete-Time Amplitude Scaling');
legend('Original Noisy Signal', 'Scaled Signal (2x)');
saveas(gcf, 'signal_operations.png');

%% Task 2: Signal Delay
delay = 5;
delayed = [zeros(1, delay), measured]; % Add zeros before the original signal

n_measured = 0:length(measured)-1;
n_delayed = 0:length(delayed)-1;

figure;
plot(n_measured, measured, 'Color', [0.6 0.6 0.6], 'LineWidth', 1.5);
hold on;
plot(n_delayed, delayed, 'r', 'LineWidth', 1.5);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Task 2: Discrete-Time Signal Delay');
legend('Original Noisy Signal', 'Delayed Signal (5 samples)');

%% Task 3: Five-Point Moving-Average Filter
h5 = ones(1,5)/5;
filtered5 = conv(measured, h5, 'same');

figure;
plot(n, clean, '--b', 'LineWidth', 1.5);
hold on;
plot(n, measured, 'Color', [0.6 0.6 0.6]);
plot(n, filtered5, 'r', 'LineWidth', 2);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Task 3: Noise Filtering (5-Point Moving Average)');
legend('Clean Signal', 'Noisy Signal', '5-Point Filtered Signal');
saveas(gcf, 'noise_filtering.png');

%% Task 4: Compare Two Filter Lengths
h15 = ones(1,15)/15;
filtered15 = conv(measured, h15, 'same');

figure;
plot(n, clean, '--b', 'LineWidth', 1.5);
hold on;
plot(n, measured, 'Color', [0.6 0.6 0.6]);
plot(n, filtered5, 'r', 'LineWidth', 1.5);
plot(n, filtered15, 'g', 'LineWidth', 2);
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Task 4: Filter Length Comparison');
legend('Clean Signal', 'Noisy Signal', '5-Point Filtered', '15-Point Filtered');
saveas(gcf, 'filter_comparison.png');