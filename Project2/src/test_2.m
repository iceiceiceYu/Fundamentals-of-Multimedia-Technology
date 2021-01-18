% 读取图片
image_name = "satomi.jpg";
I = imread(image_name);

% 把图像数据类型转换为double类型，用于计算转换后灰度图片的方差
I = im2double(I);

% 用灰度转换公式转换为灰度图片
gray_I = 0.29900 * I(:, :, 1) + 0.58700 * I(:, :, 2) + 0.11400 * I(:, :, 3);

% 计算灰度图片的方差并输出
variance = var(gray_I(:));
fprintf("灰度图片的方差为：%f\n", variance);

% 显示对比图片
figure
subplot(1, 2, 1), imshow(I), title("原图");
subplot(1, 2, 2), imshow(gray_I), title("灰度图");

% 保存图片
imwrite(gray_I, "gray_" + image_name);