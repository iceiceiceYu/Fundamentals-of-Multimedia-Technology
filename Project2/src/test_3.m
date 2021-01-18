% ��ȡͼƬ
image_name = "gray_satomi.jpg";
I = imread(image_name);

% �Ҷ�����
J = imadjust(I, [0.2, 0.6], [0, 1]);

% ֱ��ͼ���⻯
H = histeq(I);

% ��ʾ�Ա�ͼƬ
figure
subplot(3, 2, 1), imshow(I), title("ԭͼ");
subplot(3, 2, 2), imhist(I), title("�Ҷ�ֵ�ֲ�ֱ��ͼ");
subplot(3, 2, 3), imshow(J), title("�Ҷ�����ͼ");
subplot(3, 2, 4), imhist(J), title("�Ҷ�ֵ�ֲ�ֱ��ͼ");
subplot(3, 2, 5), imshow(H), title("ֱ��ͼ���⻯");
subplot(3, 2, 6), imhist(H), title("�Ҷ�ֵ�ֲ�ֱ��ͼ");

% ����ͼƬ
imwrite(J, "gray_scale_stretching_" + image_name);
imwrite(H, "histogram_equalization_" + image_name);