## TASK 2

**Which signal changes fastest?**
The 10 Hertz wave changes fastest because it has the fastest frequency and oscillates ten times in one second.

**Which signal has the lowest frequency?**
The signal with 2 Hz.

**How can you see the difference in the plots?**
The speed at which the signals oscillate.

---

## TASK 3 

**Which signal has the largest amplitude?**
The signal with the highest and lowest peaks / variation in y. 

**Does changing amplitude change frequency?**
No changing amplitude does not change frequency.

**Give one real-world example where amplitude is important.**
Setting voltage thresholds for a trigger on a picoscope.

---

## TASK 4 

**What changed after adding noise?**
There is no longer a simple function to represent the signal.

**Can you still recognize the original signal?**
Yes as long as the noise is not too strong

**Give one real-world source of signal noise.**
Electromagnetic interference in circuits can cause noise in voltage.

---

## AI Use for Task Questions

**Include the following in your README:**

**AI Tool Used:**
Google Gemini

**Prompt:**
Here is a matlab file I want you to generate an optimized version of this code:
```matlab
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

%

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

%%

%

%Answer these questions in your README:

%

%Which signal changes fastest?

%Which signal has the lowest frequency?

%How can you see the difference in the plots?

%

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

% Task 4: Add Noise

%Generate a clean sine wave.

f = 2;

cleansignal = sin(2*pi*f*t);

noise = 0.1 * randn(size(t));

signal = cleansignal + noise;

plot(t,signal)

f = 2;

cleansignal = sin(2*pi*f*t);

%Add random noise to create a noisy signal.

noise = 0.1 * randn(size(t));

noisysignal = cleansignal + noise;

plot(t,noisysignal) 

```

**What AI Suggested:**
```matlab
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
w2 = sin(2*pi*2*t);
% We can just reuse w1 here since it is already exactly 5 Hz
w3 = sin(2*pi*10*t);

figure; % Opens a second window
subplot(3,1,1);
plot(t, w2);
title('2 Hz');

subplot(3,1,2);
plot(t, w1);
title('5 Hz');

subplot(3,1,3);
plot(t, w3);
title('10 Hz');

%% Task 3: Compare Different Amplitudes
% Using 2 Hz for all signals as you originally set up
w4 = 0.5 * sin(2*pi*2*t);
w5 = 1.0 * sin(2*pi*2*t); % Kept independent for clarity, though it equals w2
w6 = 2.0 * sin(2*pi*2*t);

figure; % Opens a third window
subplot(3,1,1);
plot(t, w4);
ylim([-2.5 2.5]); % Slightly wider than 2 so the wave doesn't touch the very edge
title('Amplitude 0.5');

subplot(3,1,2);
plot(t, w5);
ylim([-2.5 2.5]);
title('Amplitude 1');

subplot(3,1,3);
plot(t, w6);
ylim([-2.5 2.5]);
title('Amplitude 2');

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
```
**Did the code work immediately?**
Yes it did

**What did you modify?**
I added for loops for the repetitive signal generation and plotting. I as assuming the LLM would generate the code this way however it did not so I implemented it myself.

**How did you verify the result?**
I analyzed the figures generated 
