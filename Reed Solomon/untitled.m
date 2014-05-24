I = imread('gray scale.jpg');

I1 = imread('Self Quantization 1.jpg');

p = I-I1;



imwrite(p,'diff.jpg');