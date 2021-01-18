I_1 = imread('test.bmp');
I_2 = imread('test.jpeg');
I_3 = imread('test2.bmp');
I_4 = imread('test2.jpeg');

figure
subplot(2, 2, 1), imshow(I_1), title('test.bmp');
subplot(2, 2, 2), imshow(I_2), title('test.jpeg');
subplot(2, 2, 3), imshow(I_3), title('test2.bmp');
subplot(2, 2, 4), imshow(I_4), title('test2.jpeg');
