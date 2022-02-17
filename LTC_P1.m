%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LTC. P1: Visualizacion de señales en Matlab
% Febrero de 2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%% Reseteo del espacio de trabajo:
clear all, close all, clc

%% Valores iniciales. RELLENAR con los datos proporcionados por el profesor:
f0 = ; % frecuencia de la sinusoide (Hz)
A = ; % amplitud de pico de la sinusoide (V)
G = ; % ganancia del amplificador (dB)

% Otros parametros
fs = 2^12; % frecuencia de muestreo (Hz)
N = fs; % numero de muestras
Z = 50;	% impedancia (ohmios)
Fn = 50; % figura de ruido del analizador (dB)

%% Creacion de x(t)
T = 1/fs; % tiempo de muestreo: inversa de fs
t = 0:T:(N-1)*T; % Vector con los instantes de muestreo
x = A * sin(2*pi*f0*t); % Sinusoide

%% Visualizacion de x(t) en osciloscopio y analizador
fig1 = figure(1); time_spectrum(x,T,Z,'x(t), sinusoide antes del amplificador','log',Fn);
fig1.Name = 'Señal x(t)'; fig1.NumberTitle = 'off';
subplot(211); axis([0 0.5 -max(x)*1.2 max(x)*1.2]);

%% Amplificacion
% La siguiente linea genera el vector y(t) a partir de x(t):
y = x * 10^(G/20); % multiplicación por ganancia (veces de tensión)

%% Medidas de potencia
% Sinusoide antes del amplificador: 
px_W = powmeter(x,fs,f0,1,Z); % muestra el valor (W)
Px_dBm = 10*log10(px_W)+30; % muestra el valor en dBm

% Sinusoide despues del amplificador:
py_W = powmeter(y,fs,f0,1,Z); % muestra el valor (W)
Py_dBm = 10*log10(py_W)+30; % muestra el valor en dBm

disp(['Potencia de cada señal'])
disp(['Señal x(t):  ' num2str(px_W,'%3.3e') ' W    ' num2str(Px_dBm,'%+4.1f') ' dBm']);
disp(['Señal y(t):  ' num2str(py_W,'%3.3e') ' W    ' num2str(Py_dBm,'%+4.1f') ' dBm']);

%% Visualizacion de y(t) en osciloscopio y analizador
fig2 = figure(2); time_spectrum(y,T,Z,'y(t), sinusoide después del amplificador','log',Fn);
fig2.Name = 'Señal y(t)'; fig2.NumberTitle = 'off';
subplot(211); axis([0 0.5 -max(y)*1.2 max(y)*1.2]);

