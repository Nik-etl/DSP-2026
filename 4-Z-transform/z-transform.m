clear; clc; close all;

%% Part 1: A signal and its Z-transform
x = [1 2 1];
n = 0:length(x)-1;

% Delay the signal by one sample
xDelayed = [0 x];
nDelayed = 0:length(xDelayed)-1;

figure;
subplot(2,1,1);
stem(n, x, 'filled');
title('Original Signal x[n]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nDelayed, xDelayed, 'filled');
title('One-Sample Delay x[n-1]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

%% Part 2: A system with one sample delay (Task 4 & 5)
% Coefficients of H(z) = 0.5 + 0.5*z^(-1)
b = [0.5 0.5];
a = 1;

% Add one zero to show the final output sample
xInput = [x 0];
y = filter(b, a, xInput);
nOutput = 0:length(y)-1;

figure;
subplot(2,1,1);
stem(nOutput, xInput, 'filled');
title('Input x[n]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nOutput, y, 'filled');
title('Output y[n] (b = [0.5 0.5])');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

disp('Output samples for b = [0.5 0.5]:');
disp(y);

%% Part 2: Modified system (Task 6)
% Updated Coefficients for H(z) = 0.8 + 0.2*z^(-1)
b_new = [0.8 0.2];
y_new = filter(b_new, a, xInput);

figure;
subplot(2,1,1);
stem(nOutput, xInput, 'filled');
title('Input x[n]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nOutput, y_new, 'filled');
title('Output y_new[n] (b = [0.8 0.2])');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

disp('Output samples for b = [0.8 0.2]:');
disp(y_new);