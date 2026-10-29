%% FILTER ASSIGNMENT - Part A (sensor signal) and Part B (50 Hz audio hum)
% Requires: Signal Processing Toolbox (fir1, butter, filtfilt, freqz, pwelch, spectrogram)
% Run section by section (Ctrl+Enter) or run the whole file.
clear; clc; close all;

%% ======================= PART A: FILTER A SENSOR SIGNAL =======================
Fs = 1000;
t  = (0:1/Fs:2-1/Fs)';
rng(7);
clean = sin(2*pi*5*t) + 0.35*sin(2*pi*12*t);
noise = 0.35*sin(2*pi*50*t) + 0.20*sin(2*pi*137*t) + 0.25*randn(size(t));
x = clean + noise;

% --- Filters (20 Hz cutoff) ---
fc = 20;
bFIR = fir1(60, fc/(Fs/2), 'low');                 % order 60 -> 61 taps
[bIIR, aIIR] = butter(4, fc/(Fs/2), 'low');        % 4th-order Butterworth
yFIR = filtfilt(bFIR, 1, x);
yIIR = filtfilt(bIIR, aIIR, x);

% --- A1: time-domain comparison, first 0.2 s, same axes ---
idx = t <= 0.2;
figure('Name','A1 Time-domain 0-0.2 s');
plot(t(idx), clean(idx), 'k', 'LineWidth', 2); hold on;
plot(t(idx), x(idx),     'Color', [0.7 0.7 0.7]);
plot(t(idx), yFIR(idx),  'b', 'LineWidth', 1.3);
plot(t(idx), yIIR(idx),  'r--', 'LineWidth', 1.3);
grid on; xlabel('Time (s)'); ylabel('Amplitude');
title('Clean, noisy, FIR and IIR outputs (0 - 0.2 s)');
legend('Clean','Noisy','FIR (filtfilt)','IIR (filtfilt)','Location','best');

% --- A2: magnitude responses with freqz ---
Nfft = 8192;
[hF, f] = freqz(bFIR, 1, Nfft, Fs);
[hI, ~] = freqz(bIIR, aIIR, Nfft, Fs);
dbF = 20*log10(max(abs(hF), eps));
dbI = 20*log10(max(abs(hI), eps));

figure('Name','A2 Magnitude responses');
plot(f, dbF, 'b', f, dbI, 'r', 'LineWidth', 1.3); hold on;
plot(f, 2*dbF, 'b--', f, 2*dbI, 'r--', 'LineWidth', 1);   % filtfilt = |H|^2 -> dB doubles
xline(fc, 'k--', '20 Hz cutoff', 'LabelVerticalAlignment','bottom');
grid on; xlim([0 200]); ylim([-150 5]);
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
title('Magnitude response (solid = single pass, dashed = effective filtfilt)');
legend('FIR single pass','IIR single pass','FIR filtfilt (2x dB)','IIR filtfilt (2x dB)', ...
       'Location','southwest');

% --- A3: single-sided amplitude spectra ---
[fx, Ax]  = ampSpec(x,    Fs);
[~,  AF]  = ampSpec(yFIR, Fs);
[~,  AI]  = ampSpec(yIIR, Fs);

figure('Name','A3 Amplitude spectra');
plot(fx, Ax, 'Color', [0.6 0.6 0.6]); hold on;
plot(fx, AF, 'b', 'LineWidth', 1.3);
plot(fx, AI, 'r--', 'LineWidth', 1.3);
grid on; xlim([0 200]);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Single-sided amplitude spectrum');
legend('Noisy','FIR output','IIR output');
for fk = [5 12 50 137]
    xline(fk, ':', sprintf('%d Hz', fk));
end

% Amplitudes read at the four key frequencies (tones fall exactly on FFT bins:
% resolution = Fs/N = 0.5 Hz)
keyF = [5 12 50 137];
df   = fx(2) - fx(1);
kIdx = round(keyF/df) + 1;
fprintf('\n--- Amplitude at key frequencies (true values: 1, 0.35, 0.35, 0.20) ---\n');
fprintf('%8s %10s %10s %10s\n', 'f (Hz)', 'Noisy', 'FIR', 'IIR');
for k = 1:numel(keyF)
    fprintf('%8d %10.4f %10.4f %10.4f\n', keyF(k), Ax(kIdx(k)), AF(kIdx(k)), AI(kIdx(k)));
end

% Gain of the filters at those frequencies
gF = 20*log10(max(abs(freqz(bFIR, 1,    keyF, Fs)), eps));
gI = 20*log10(max(abs(freqz(bIIR, aIIR, keyF, Fs)), eps));
fprintf('\n--- Filter gain at key frequencies (dB) ---\n');
fprintf('%8s %14s %14s %14s %14s\n', 'f (Hz)','FIR 1-pass','FIR filtfilt','IIR 1-pass','IIR filtfilt');
for k = 1:numel(keyF)
    fprintf('%8d %14.2f %14.2f %14.2f %14.2f\n', keyF(k), gF(k), 2*gF(k), gI(k), 2*gI(k));
end

% --- A4: RMSE against the known clean signal ---
rmseNoisy = rmseCalc(x,    clean);
rmseFIR   = rmseCalc(yFIR, clean);
rmseIIR   = rmseCalc(yIIR, clean);

% RMSE with the first/last 0.1 s removed -> isolates edge effects
trim = round(0.1*Fs);
mid  = (trim+1):(numel(t)-trim);
rmseFIRmid = rmseCalc(yFIR(mid), clean(mid));
rmseIIRmid = rmseCalc(yIIR(mid), clean(mid));

fprintf('\n--- RMSE vs clean ---\n');
fprintf('Noisy input        : %.4f\n', rmseNoisy);
fprintf('FIR output (all)   : %.4f   | excluding 0.1 s at each end: %.4f\n', rmseFIR, rmseFIRmid);
fprintf('IIR output (all)   : %.4f   | excluding 0.1 s at each end: %.4f\n', rmseIIR, rmseIIRmid);

% --- A5: design comparison numbers ---
fprintf('\n--- Design comparison ---\n');
fprintf('FIR: %d coefficients (order %d)\n', numel(bFIR), numel(bFIR)-1);
fprintf('IIR: %d numerator + %d denominator coefficients (order 4)\n', numel(bIIR), numel(aIIR));

fine  = linspace(0, 200, 20001);
magF  = 20*log10(max(abs(freqz(bFIR, 1,    fine, Fs)), eps));
magI  = 20*log10(max(abs(freqz(bIIR, aIIR, fine, Fs)), eps));
fprintf('\nEffective filtfilt response (2x single-pass dB):\n');
for thr = [-3 -20 -40]
    fF = fine(find(2*magF < thr, 1, 'first'));
    fI = fine(find(2*magI < thr, 1, 'first'));
    fprintf('  first frequency below %4d dB:  FIR = %6.2f Hz,  IIR = %6.2f Hz\n', thr, fF, fI);
end
fprintf('  gain at exactly 20 Hz (filtfilt): FIR = %.2f dB, IIR = %.2f dB\n', ...
        2*20*log10(abs(freqz(bFIR,1,20,Fs))), 2*20*log10(abs(freqz(bIIR,aIIR,20,Fs))));

%% ======================= PART B: REDUCE 50 Hz HUM IN AUDIO =======================
% NOTE: the assignment text has a typo "y(;" - the correct form is y(:) (handel is mono).
hd       = load('handel');          % struct with fields y and Fs (avoids overwriting Part A's Fs)
xClean   = hd.y(:);
FsA      = hd.Fs;
tAudio   = (0:numel(xClean)-1)'/FsA;

% Sanity checks required by the assignment
assert(FsA > 102, 'Fs must exceed 102 Hz to represent 50 Hz.');
assert(all([49 51]/(FsA/2) < 1), 'Normalised stop-band edges must be < 1.');

xHum = xClean + 0.15*sin(2*pi*50*tAudio);

% Narrow band-stop (49-51 Hz). butter(2,[lo hi],'stop') gives a 4th-order filter overall.
[bN, aN] = butter(2, [49 51]/(FsA/2), 'stop');
yAudio   = filtfilt(bN, aN, xHum);

% Wide band-stop (45-55 Hz)
[bW, aW] = butter(2, [45 55]/(FsA/2), 'stop');
yWide    = filtfilt(bW, aW, xHum);

% --- B1: waveforms (0.1 s = 5 hum cycles), identical axes ---
seg = tAudio >= 2.0 & tAudio < 2.1;
yl  = [-1.2 1.2] * max(abs([xClean(seg); xHum(seg); yAudio(seg)]));
figure('Name','B1 Waveforms');
subplot(3,1,1); plot(tAudio(seg), xClean(seg));  ylim(yl); grid on; title('Clean'); ylabel('Amp.');
subplot(3,1,2); plot(tAudio(seg), xHum(seg));    ylim(yl); grid on; title('Hum added (50 Hz, 0.15)'); ylabel('Amp.');
subplot(3,1,3); plot(tAudio(seg), yAudio(seg));  ylim(yl); grid on; title('Filtered (49-51 Hz stop)'); ylabel('Amp.');
xlabel('Time (s)');

% --- B2: spectra (Welch) and spectrograms ---
win = hann(8192); nov = 4096; nfft = 16384;
[pC, fp] = pwelch(xClean, win, nov, nfft, FsA);
[pH, ~ ] = pwelch(xHum,   win, nov, nfft, FsA);
[pY, ~ ] = pwelch(yAudio, win, nov, nfft, FsA);

figure('Name','B2 Spectrum (0-200 Hz)');
plot(fp, 10*log10(pC), 'k', fp, 10*log10(pH), 'r', fp, 10*log10(pY), 'b', 'LineWidth', 1.2);
grid on; xlim([0 200]); xlabel('Frequency (Hz)'); ylabel('PSD (dB/Hz)');
xline(50, 'k--', '50 Hz');
legend('Clean','Hum added','Filtered (49-51 Hz)'); title('Welch PSD around the hum');

sigs  = {xClean, xHum, yAudio};
names = {'Clean','Hum added','Filtered (49-51 Hz)'};
figure('Name','B2 Spectrograms');
ax = gobjects(1,3);
for k = 1:3
    ax(k) = subplot(3,1,k);
    spectrogram(sigs{k}, hann(4096), 3072, 4096, FsA, 'yaxis');
    ylim([0 0.3]);                       % 0-300 Hz (axis is in kHz)
    title(names{k});
end
cl = caxis(ax(2));                       % same colour scale for all three
for k = 1:3, caxis(ax(k), cl); end

% --- B3: playback at the SAME gain ---
playAudio = true;                        % set false to skip playback
g = 0.95 / max(abs([xClean; xHum; yAudio; yWide]));   % one common gain, avoids clipping
if playAudio
    disp('Playing: hum-added ...');  sound(g*xHum,   FsA); pause(numel(xHum)/FsA + 0.5);
    disp('Playing: filtered 49-51 Hz ...'); sound(g*yAudio, FsA); pause(numel(yAudio)/FsA + 0.5);
    disp('Playing: filtered 45-55 Hz ...'); sound(g*yWide,  FsA); pause(numel(yWide)/FsA + 0.5);
end

% --- B4: 50 Hz amplitude before/after + filter attenuation ---
midA = tAudio > 0.5 & tAudio < tAudio(end)-0.5;     % avoid filtfilt edge transients
ampClean = fitAmp(xClean(midA), tAudio(midA), 50);
ampHum   = fitAmp(xHum(midA),   tAudio(midA), 50);
ampFilt  = fitAmp(yAudio(midA), tAudio(midA), 50);
fprintf('\n--- 50 Hz amplitude (least-squares sine/cosine fit at 50 Hz) ---\n');
fprintf('Clean audio     : %.4f  (native 50 Hz content of the recording)\n', ampClean);
fprintf('Hum added       : %.4f  (added hum = 0.15)\n', ampHum);
fprintf('Filtered 49-51  : %.4f\n', ampFilt);

gN50 = 20*log10(max(abs(freqz(bN, aN, 50, FsA)), eps));
gW50 = 20*log10(max(abs(freqz(bW, aW, 50, FsA)), eps));
fprintf('\nFilter attenuation at 50 Hz from freqz: narrow = %.1f dB (single), %.1f dB (filtfilt)\n', gN50, 2*gN50);
fprintf('                                        wide   = %.1f dB (single), %.1f dB (filtfilt)\n', gW50, 2*gW50);

% --- B5: narrow vs wide stop band ---
% (a) response comparison
fz = linspace(20, 80, 6000);
mN = 20*log10(max(abs(freqz(bN, aN, fz, FsA)), eps));
mW = 20*log10(max(abs(freqz(bW, aW, fz, FsA)), eps));
figure('Name','B5 Narrow vs wide stop band');
plot(fz, 2*mN, 'b', fz, 2*mW, 'r', 'LineWidth', 1.3); grid on; ylim([-80 5]);
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB, effective filtfilt)');
legend('49-51 Hz','45-55 Hz','Location','south'); title('Effective band-stop responses');

% (b) damage to the useful audio: pass the CLEAN audio through each filter
dmgN = rmseCalc(filtfilt(bN, aN, xClean), xClean);
dmgW = rmseCalc(filtfilt(bW, aW, xClean), xClean);
fprintf('\n--- Damage to useful audio (RMSE of filtered CLEAN audio vs clean) ---\n');
fprintf('Narrow 49-51 Hz: %.6f\nWide   45-55 Hz: %.6f\n', dmgN, dmgW);

% (c) total error after hum removal (output vs clean)
fprintf('\n--- Total error (hum-added audio filtered, vs clean) ---\n');
fprintf('Hum added, unfiltered : %.6f\n', rmseCalc(xHum,   xClean));
fprintf('Narrow 49-51 Hz       : %.6f\n', rmseCalc(yAudio, xClean));
fprintf('Wide   45-55 Hz       : %.6f\n', rmseCalc(yWide,  xClean));

% (d) hum frequency drift test (mains frequency is not always exactly 50.00 Hz)
fprintf('\n--- Residual of a unit-amplitude hum after filtering (lower = better) ---\n');
fprintf('%10s %14s %14s\n', 'Hum (Hz)', 'Narrow', 'Wide');
for f0 = [49.5 50 50.5 51.5 53]
    h  = sin(2*pi*f0*tAudio);
    rN = fitAmp(filtfilt(bN, aN, h), tAudio, f0);   % fit on whole record: hum only, no audio
    rW = fitAmp(filtfilt(bW, aW, h), tAudio, f0);
    fprintf('%10.1f %14.4f %14.4f\n', f0, rN, rW);
end

% --- Optional: write the audio files for listening elsewhere ---
% audiowrite('hum_added.wav',   g*xHum,   FsA);
% audiowrite('filtered_narrow.wav', g*yAudio, FsA);
% audiowrite('filtered_wide.wav',   g*yWide,  FsA);

%% ======================= LOCAL FUNCTIONS =======================
function r = rmseCalc(a, b)
    r = sqrt(mean((a(:) - b(:)).^2));
end

function [f, A] = ampSpec(sig, Fs)
    % single-sided amplitude spectrum (rectangular window; use only for bin-exact tones)
    sig = sig(:);
    N   = numel(sig);
    X   = fft(sig)/N;
    A   = abs(X(1:floor(N/2)+1));
    A(2:end-1) = 2*A(2:end-1);
    f   = Fs*(0:floor(N/2))'/N;
end

function amp = fitAmp(sig, tt, f0)
    % least-squares amplitude of a sinusoid at frequency f0
    M = [sin(2*pi*f0*tt(:)), cos(2*pi*f0*tt(:))];
    c = M \ sig(:);
    amp = hypot(c(1), c(2));
end