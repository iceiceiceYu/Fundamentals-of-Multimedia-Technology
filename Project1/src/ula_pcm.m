function [a_quan]=ula_pcm(a,n,u)
%ULA_PCM 	u-law PCM encoding of a sequence
%       	[A_QUAN]=MULA_PCM(X,N,U).
%       	a=input sequence. �����ź�
%       	n=number of quantization levels (even). ��������
%		a_quan=quantized output before encoding.
%       u the parameter of the u-law ���ɲ���

% ����ѹ������
x = ulaw(a, u);

% ��������
y = u_pcm(x, n);

% �������ź���(����ѹ�������ķ�����)
a_quan = inv_ulaw(y, u);
end