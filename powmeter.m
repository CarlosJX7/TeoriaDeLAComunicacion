function p=powmeter(x,fs,f0,B,R)
%
% Calcula la potencia, en W, que hay dentro de una banda
% espectral de la señal x.
% Parámetros de entrada:
%		x  = Señal de entrada
%		fs = Frecuencia de muestreo
%		fo = Frecuencia central de la banda
%		B  = Ancho de banda de la medida
% 		R  = Impedancia de trabajo
%
% Datos de salida
%       p = potencia en W

N=length(x);
X=fft(x,N)/N;
deltaf=fs/N;
f1=f0-B/2;
f2=f0+B/2;
n1=round(f1/deltaf)+1;
n2=round(f2/deltaf)+1;
if n1<0 disp ('Valores de entrada a la función powmeter erróneos')
    elseif n1==0 p=X(1)*conj(X(1))+2*sum(X(2:n2).*conj(X(2:n2)));
else p=2*sum(X(n1:n2).*conj(X(n1:n2)));
end
p=p/R;

% Fin de la función powmeter
