I = imread('Banana_1.jpg');
%Convert image to grayscale.

I = rgb2gray(I);
I= im2double(I);
%Apply Gabor filter to image.
%f=?/?
f = 0.15; 
wavelength = pi / f;
orientation = -10;


n2=3
sigma= [1.77881 ,0.2,3.05591];
psi= 1 ;
gamma=3;
n3=3;
lambda=[3.16418 ,3.95031,5.43590 ] ;
n4=4;
theta=[0;45;90;135;180];
[mag,phase] = imgaborfilt(I,wavelength,orientation);
%Display original image with plots of the magnitude and phase calculated by the Gabor filter.

figure
subplot(1,3,1);
imshow(I);
title('Original Image');
subplot(1,3,2);
imshow(mag,[])
title('Gabor magnitude');
subplot(1,3,3);
imshow(phase,[]);
title('Gabor phase');
imshow(phase);
banana= phase;
imshow(banana)

