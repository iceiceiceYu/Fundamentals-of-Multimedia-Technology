% ��ȡͼƬ
image_name = "satomi.jpg";
I = imread(image_name);

% �����ܶ�Ϊ0.04�Ľ�������
J2 = imnoise(I, "salt & pepper", 0.04);

% ��ֵȥ�루RGB��ͨ����
filter1 = medfilt3(J2, [3 3 1]);

% ��ֵȥ��
h = fspecial("average", [3 3]);
filter2 = imfilter(J2, h);

% ��ʾ�Ա�ͼƬ
figure
subplot(2, 2, [1 2]), imshow(J2), title("�ӽ�������ͼ");
subplot(2, 2, 3), imshow(filter1), title("��ֵȥ�루RGB��ͨ����");
subplot(2, 2, 4), imshow(filter2), title("��ֵȥ��");

% ����ͼƬ
imwrite(J2, "salt & pepper_noise_" + image_name);
imwrite(filter1, "median_filter_" + image_name);
imwrite(filter2, "average_filter_" + image_name);