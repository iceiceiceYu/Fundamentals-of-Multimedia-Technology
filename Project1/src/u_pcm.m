function [a_quan]=u_pcm(a,n)
%U_PCM  	uniform PCM encoding of a sequence
%       	[A_QUAN]=U_PCM(A,N)
%       	a=input sequence. 输入信号
%       	n=number of quantization levels (even). 量化级数
%		a_quan=quantized output before encoding.

% 获取采样点的最大值
a_max = max(abs(a));

% 将采样点映射到(-1, 1)
a_quan = a ./ a_max;

% 将(-1, 1)分成n段
for i = -1 : 2 / n : 1
    % 获取在(i, i + 2 / n)范围内的采样点
    a_quan_seg = a_quan(a_quan >= i & a_quan < (i + 2 / n));
    
    % 将这些采样点设为(最大值 + 最小值) / 2
    a_quan(a_quan >= i & a_quan < (i + 2 / n)) = a_max * (max(a_quan_seg) + min(a_quan_seg)) / 2;
end
    
end