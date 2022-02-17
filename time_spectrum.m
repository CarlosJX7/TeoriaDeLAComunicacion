function time_spectrum(x,T,R,s,lin_log,Fn)
%
% Representa en la parte superior la señal en el dominio del tiempo, 
% y en la parte inferior la pantalla de un analizador de espectros
%
% Parametros de entrada:
%   x: señal a analizar (real)
%   T: periodo de muestreo
%   R: impedancia (ohmios)
%   s: título que aparecerá en la parte superior
%   lin_log: representación lineal ('lin') o logaritmica ('log')
%   Fn: Figura de ruido (dB)
% 

a = length(x);
k = 1.38e-23; %Constante de Boltzmann
fn = 10^(Fn/10); %Factor de ruido
Te = 300*(fn-1); %Temperatura equivalente de ruido
nef = sqrt(k*Te*R/(2*T)); %Valor eficaz del ruido. El ancho de banda de ruido es fs/2
n = nef*randn(size(x));

x = x+n;
subplot(211),plot((0:a-1)*T,x,'b'),grid
xlabel('t (s)'),ylabel('V (voltios)')
title(s)
x1 = fft(x)/a;
y = x1.*conj(x1);
y = [y(1) 2*y(2:a/2)]/real(R);
eje=(1/T)*(0:a/2-1)/a;
aux=(lin_log(1:3) =='lin');
if sum(aux)==3
   subplot(212),plot(eje,y*1e3,'b')
   ylabel('mW')
else        
   subplot(212),plot(eje,10*log10(y*1e3+eps),'b')
   ylabel('dBm')
end
grid,xlabel('Hz')

% Fin de la función time_spectrum