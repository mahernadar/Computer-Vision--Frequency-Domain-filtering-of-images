clc;
clear all;
close all;

i1 = imread('elephant.jpg');% reading the images of elephant and truck
i2 = imread('truck.jpg');

i1 = rgb2gray(i1); % converting the images to gray scale
i2 = rgb2gray(i2);

% elephant frequency transformation

f1 = fft2(i1);      % obtaining the frequency transform of the image
mag1 = abs(f1);     % obtaining the magnitude from the frequency
s = log(1+fftshift(f1));    % obtaining the spectrum of frequency
phase1 = angle(f1);         % obtaining the phase from the frequency


% truck frequency transformation

f2 = fft2(i2);
mag2 = abs(f2);
s2 = log(1+fftshift(f2));
phase2 = angle(f2);



f3 = mag1.*exp(1i*phase2);          %merging the elephant magnitude witht the 
mag_elephant_phase_truck = ifft2(f3);

f4 = mag2.*exp(1i*phase1);
mag_truck_phase_elephant = ifft2(f4);



figure

subplot(2,2,1)
imshow(i1)
title('Original elephant image')

subplot(2,2,2)
imshow(i2)
title('Original elephant image')


subplot(2,2,3)
imshow(uint8(mag_truck_phase_elephant))
title('Truck magnitude + Elephant phase')

subplot(2,2,4)
imshow(uint8(mag_elephant_phase_truck))
title('Elephant magnitude + Truck phase')




