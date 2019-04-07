

clc;
clear all; 
close all;


I=imread('Apple_1.jpg');
I=rgb2gray(I);
imshow(I)
I=im2double(I);


sigma=0.3;
psi= 0.3;
gamma=0.3
n1=1
lambda= 5
n2= 2
theta=[45 90]


for i=1:n1
    l=lambda(i);
    figure
    for j=1:n2
        t=theta(j);
        g1=gabor_fn(sigma,t,l,psi,gamma);
        display('value of lambda');display(l);
        display('value of theta ');display(t);
        display('output of gabor filter will be');display(g1);
%         figure
        subplot(1,n2,j);
        GT =conv2(I,double(g1),'same')
        imshow(g1);
        
        if (j == n2)
            N=GT;
        else 
            N2=GT;
        
        end
    end
end 




