% 读取图片
image_name = "satomi.jpg";
I = imread(image_name);

% 叠加密度为0.04的椒盐噪声
J2 = imnoise(I, "salt & pepper", 0.04);

% 中值去噪（RGB三通道）
filter1 = medfilt3(J2, [3 3 1]);

% 均值去噪
h = fspecial("average", [3 3]);
filter2 = imfilter(J2, h);

% 显示对比图片
figure
subplot(2, 2, [1 2]), imshow(J2), title("加椒盐噪声图");
subplot(2, 2, 3), imshow(filter1), title("中值去噪（RGB三通道）");
subplot(2, 2, 4), imshow(filter2), title("均值去噪");

% 保存图片
imwrite(J2, "salt & pepper_noise_" + image_name);
imwrite(filter1, "median_filter_" + image_name);
imwrite(filter2, "average_filter_" + image_name);