function [a_quan]=ula_pcm(a,n,u)
%ULA_PCM 	u-law PCM encoding of a sequence
%       	[A_QUAN]=MULA_PCM(X,N,U).
%       	a=input sequence. 输入信号
%       	n=number of quantization levels (even). 量化级数
%		a_quan=quantized output before encoding.
%       u the parameter of the u-law μ律参数

% μ律压缩函数
x = ulaw(a, u);

% 均匀量化
y = u_pcm(x, n);

% μ律扩张函数(μ律压缩函数的反函数)
a_quan = inv_ulaw(y, u);
end