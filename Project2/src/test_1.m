% ����ͼƬ����
image_name = input("image:", "s");

% ��ȡͼƬ
I = imread(image_name);
[y, x, z] = size(I);

% ���ͼƬ��͸�
fprintf("image width: %d\n", x);
fprintf("image height: %d\n", y);

% ��������(x, y)��xΪ�����꣨��ͼƬ�Ŀ���yΪ�����꣨��ͼƬ�ĸߣ�
p_x = input("x:");
p_y = input("y:");

% ��������������Ϊ���ĵľŹ��񣬲���ʵ�ֱ߽��飨ֻ����Ź�������ͼ���е����ص㣩
for a = max(p_x - 1, 1) : min(p_x + 1, x)
    for b = max(p_y - 1, 1) : min(p_y + 1, y)
        % ���
        fprintf("(%d, %d): (%d, %d, %d)\n", a, b, I(b, a ,1), I(b, a ,2), I(b, a ,3));
    end
end