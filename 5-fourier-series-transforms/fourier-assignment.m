clear; clc; close all;
%%
% square wave
t = linspace(-1, 1, 4000);
H_vals = [1, 3, 9, 25];

figure;
for i = 1:length(H_vals)
    H = H_vals(i);
    x = zeros(size(t));
    for k = 1:2:H
        x = x + (4/pi) * sin(2*pi*k*t) / k;
    end

    subplot(2, 2, i);
    plot(t, x, 'b', 'LineWidth', 1);
    grid on;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(['Square Wave (H = ', num2str(H), ')']);
end
saveas(gcf, 'square-wave-comparison.png');
%% FFT

fs = 200;
T = 1;
t = 0:1/fs:T-1/fs;
x = 0.8*sin(2*pi*15*t) + 0.4*sin(2*pi*40*t);

figure;
subplot(2,1,1);
plot(t, x, 'b');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain Signal');

% FFT Calculation
N = length(x);
Y = fft(x);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:N/2)/N;

subplot(2,1,2);
plot(f, P1, 'r');
grid on;
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Single-Sided Amplitude Spectrum');

saveas(gcf, 'two-frequency-spectrum.png');
%%
% spectral leakage

d = 4;   % Replaced with student digit
f2 = 13.2 + 0.17*d;
fs = 200;

% Helper function to calculate FFT and frequency vector
function [f, P1] = get_spectrum(x, fs, n_fft)
if nargin < 3
    n_fft = length(x);
end
Y = fft(x, n_fft);
P2 = abs(Y/n_fft);
P1 = P2(1:floor(n_fft/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:floor(n_fft/2))/n_fft;
end

% 1-Second Recording
T1 = 1;
t1 = 0:1/fs:T1-1/fs;
x1 = 0.8*sin(2*pi*15*t1) + 0.4*sin(2*pi*f2*t1);

% 4-Second Recording
T4 = 4;
t4 = 0:1/fs:T4-1/fs;
x4 = 0.8*sin(2*pi*15*t4) + 0.4*sin(2*pi*f2*t4);

figure;
% 1-Second Spectrum
[f1, P1_1] = get_spectrum(x1, fs);
subplot(3,1,1);
plot(f1, P1_1);
xlim([0 50]); grid on;
title('1-Second Recording Spectrum');
xlabel('Frequency (Hz)'); ylabel('Amplitude');

% 4-Second Spectrum
[f4, P1_4] = get_spectrum(x4, fs);
subplot(3,1,2);
plot(f4, P1_4);
xlim([0 50]); grid on;
title('4-Second Recording Spectrum');
xlabel('Frequency (Hz)'); ylabel('Amplitude');

% Zero-padded 1-Second Spectrum
[f_pad, P1_pad] = get_spectrum(x1, fs, 4*length(x1));
subplot(3,1,3);
plot(f_pad, P1_pad);
xlim([0 50]); grid on;
title('Zero-Padded 1-Second Spectrum (N = 4*L)');
xlabel('Frequency (Hz)'); ylabel('Amplitude');

saveas(gcf, 'leakage-comparison.png');
%% DFT vs DTFT

x = [1 1 1 1];
n = 0:length(x)-1;

% Calculate DTFT
w = linspace(-pi, pi, 1000);
X = x * exp(-1j * (n.' * w));

% Calculate DFT N=4
N4 = 4;
X_dft4 = fftshift(fft(x, N4));
w_dft4 = linspace(-pi, pi - 2*pi/N4, N4);

% Calculate DFT N=64
N64 = 64;
X_dft64 = fftshift(fft(x, N64));
w_dft64 = linspace(-pi, pi - 2*pi/N64, N64);

figure;
plot(w, abs(X), 'b', 'LineWidth', 1.5);
hold on;
stem(w_dft4, abs(X_dft4), 'r', 'filled', 'LineWidth', 1.5, 'MarkerSize', 7);
stem(w_dft64, abs(X_dft64), 'g.', 'LineWidth', 1);
grid on;
xlabel('Angular frequency (rad/sample)');
ylabel('Magnitude');
title('DTFT vs DFT Comparison');
legend('DTFT', 'DFT (N=4)', 'DFT (N=64)');

saveas(gcf, 'dtft-dft-comparison.png');