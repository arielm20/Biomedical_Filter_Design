% Assignment 4 -- EEG Analysis
%Sharon Cai - cais12
%Ariel Motsenyat - motsenya 

Fs = 200; % sampling rate
N = 6008; % # samples (array size)
t = (0:N-1)/Fs; % time vector

load('EEGdata_assignment4.mat');
x = EEGa4;

% input time-domain plot of the EEG vector
figure
subplot(1,1,1)
plot(t,x)
axis([0 10 -inf inf])
title('Input Time-Domain Waveform of EEG signal')
ylabel('Vectoral Ground Reaction Force (N)')
xlabel('time (s)')

[Mx_full,phx_full,f_full] = fourier_dt(x,Fs,'half'); %fourier_dt calculates magnitude spectra of EEG data

% input magnitude spectrum of EEG data 
figure
subplot(2,1,1)
plot(f_full,Mx_full)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('EEG Input Magnitude Spectra')
xlim([50 70])
%ylim([0 200])

% input phase spectrum of EEG data 
figure
subplot(2,1,1)
plot(f_full,phx_full)
ylabel('<X(f)')
xlabel('f(Hz)')
title('EEG Input Phase Spectra')
xlim([50 70])

%Load IIR Filtered Data
filterdata = load('EEGIIR.mat');
IIR_hd = filterdata.Hd;
IIR_filt = filter(IIR_hd,x);

%Load FIR Filtered Data
filterdata = load('EEGFIR.mat');
FIR_hd = filterdata.Hd;
FIR_filt = filter(FIR_hd,x);

% output time-domain plot of the IIR and FIR filtered EEG vector
figure
subplot(2,1,1)
plot(t,IIR_filt)
title('Output Time-Domain Waveform of EEG signal - IIR Notch Filter')
ylabel('Amplitude (N)')
xlabel('time (s)')
xlim([0 10])
subplot(2,1,2)
plot(t,FIR_filt)
title('Output Time-Domain Waveform of EEG signal - FIR Notch Filter')
ylabel('Amplitude (N)')
xlabel('time (s)')
xlim([0 10])


[Mx_IIR,phx_IIR,f_IIR] = fourier_dt(IIR_filt,Fs,'half');
[Mx_FIR,phx_FIR,f_FIR] = fourier_dt(FIR_filt,Fs,'half');

% plot Magnitude spectrum for EEG - IIR and FIR
figure
subplot(2,1,1)
plot(f_IIR,Mx_IIR)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('EEG Output Magnitude Spectra - IIR Notch Filter')
xlim([50 70]) 
subplot(2,1,2)
plot(f_FIR,Mx_FIR)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('EEG Output Magnitude Spectra - FIR Notch Filter')
xlim([50 70])

% plot Phase spectrum for EEG - IIR and FIR
figure
subplot(2,1,1)
plot(f_IIR,phx_IIR)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('EEG Output Phase Spectra - IIR Notch Filter')
xlim([50 70])
subplot(2,1,2)
plot(f_FIR,phx_FIR)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('EEG Output Phase Spectra - FIR Notch Filter')
xlim([50 70])
