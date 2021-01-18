% ��ȡͼƬ
image_name = "satomi.jpg";
I = imread(image_name);

% ��ͼ����������ת��Ϊdouble���ͣ����ڼ���ת����Ҷ�ͼƬ�ķ���
I = im2double(I);

% �ûҶ�ת����ʽת��Ϊ�Ҷ�ͼƬ
gray_I = 0.29900 * I(:, :, 1) + 0.58700 * I(:, :, 2) + 0.11400 * I(:, :, 3);

% ����Ҷ�ͼƬ�ķ�����
variance = var(gray_I(:));
fprintf("�Ҷ�ͼƬ�ķ���Ϊ��%f\n", variance);

% ��ʾ�Ա�ͼƬ
figure
subplot(1, 2, 1), imshow(I), title("ԭͼ");
subplot(1, 2, 2), imshow(gray_I), title("�Ҷ�ͼ");

% ����ͼƬ
imwrite(gray_I, "gray_" + image_name);