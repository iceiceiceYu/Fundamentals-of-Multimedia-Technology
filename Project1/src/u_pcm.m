function [a_quan]=u_pcm(a,n)
%U_PCM  	uniform PCM encoding of a sequence
%       	[A_QUAN]=U_PCM(A,N)
%       	a=input sequence. �����ź�
%       	n=number of quantization levels (even). ��������
%		a_quan=quantized output before encoding.

% ��ȡ����������ֵ
a_max = max(abs(a));

% ��������ӳ�䵽(-1, 1)
a_quan = a ./ a_max;

% ��(-1, 1)�ֳ�n��
for i = -1 : 2 / n : 1
    % ��ȡ��(i, i + 2 / n)��Χ�ڵĲ�����
    a_quan_seg = a_quan(a_quan >= i & a_quan < (i + 2 / n));
    
    % ����Щ��������Ϊ(���ֵ + ��Сֵ) / 2
    a_quan(a_quan >= i & a_quan < (i + 2 / n)) = a_max * (max(a_quan_seg) + min(a_quan_seg)) / 2;
end
    
end