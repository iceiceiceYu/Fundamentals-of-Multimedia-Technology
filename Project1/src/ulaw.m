function [z]=ulaw(y,u)
%		u-law nonlinearity for nonuniform PCM
%		X=ULAW(Y,U).
%		Y=input vector.

% ����ѹ������
z = sign(y) .* log(1 + u * abs(y ./ max(abs(y)))) ./ log(1 + u);
end