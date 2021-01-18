t=0:0.0001:2*pi;
y=cos(t);
z1=u_pcm(y,64);
z2=ula_pcm(y,64,255);
plot(t,y,t,z1,'r',t,z2,'g');
legend('cos函数','均匀量化结果','μ律非均匀量化结果','Location','SouthEast');
title("余弦信号的均匀量化和μ律非均匀量化");