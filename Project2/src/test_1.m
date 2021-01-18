% 输入图片名称
image_name = input("image:", "s");

% 读取图片
I = imread(image_name);
[y, x, z] = size(I);

% 输出图片宽和高
fprintf("image width: %d\n", x);
fprintf("image height: %d\n", y);

% 输入坐标(x, y)，x为横坐标（即图片的宽），y为纵坐标（即图片的高）
p_x = input("x:");
p_y = input("y:");

% 遍历以输入坐标为中心的九宫格，并且实现边界检查（只输出九宫格里在图像中的像素点）
for a = max(p_x - 1, 1) : min(p_x + 1, x)
    for b = max(p_y - 1, 1) : min(p_y + 1, y)
        % 输出
        fprintf("(%d, %d): (%d, %d, %d)\n", a, b, I(b, a ,1), I(b, a ,2), I(b, a ,3));
    end
end