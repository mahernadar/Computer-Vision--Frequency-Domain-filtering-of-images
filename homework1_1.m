clc;
clear all;
close all;

I = imread('moon.jpg');
size = size(I);
I2 = zeros (size(1),size(2));



% Generating the noise matrix
I2 = zeros(size(1),size(2));
noise_freq1 = 1/8;
for i=1:size(1)
    I2(i,:) = sin(i*noise_freq1)*127; % Sinusoidal noise
end

I2 = uint8 (I2);
 
f = fft2(I)/255;            %fourrier transform of original image
fs = fftshift(double(f));   % shifting the fourrier transform to be centered


noise_image = imfuse(I,I2,'blend');    %noise image and its fourrier transform    
f7 = fft2(noise_image)/255;
f7s = fftshift(double(f7));

f7s2 = f7s;



s1 = log(1+fs);  % spectrum of original and noise images
s2 = log(1+f7s); 
s22 = s2; 

for i = 1:size(1)   % analysing the spectrum and deleting (zeroing) the pixels of the bright frequencies in the fourrier transform accordingly 
    for j = 1:size(2)
        if abs (s2(i,j)) > max(max(abs(s2)))*0.6
             f7s(i,j) = 0;
             s2(i,j) = 0;
        end
    end
end

for i = size(1)/2 - 4: size(1)/2 + 4  % restoring the central high frequencies in the fourrier transform
    for j = round(size(2)/2) - 4: round(size(2)/2) + 4
        
    f7s(i,j) = f7s2(i,j);
    s2(i,j) = s22(i,j) 
    end
end



F = ifftshift(f7s);    % inverse shift og the fourrier
clean_image = real(ifft2(F));   % inverse of the fourrier transform

figure
imshow(clean_image,[])
title('cleaned image')



    figure
    subplot(1,3,1)
    imshow (I,[])
    title('Original image')

    subplot(1,3,2)
    imshow(noise_image,[])
    title('Noise image')
    
    subplot(1,3,3)
    imshow(clean_image,[])
    title('Cleaned image')
    % figure
% subplot(1,3,1)
% imshow (I2)
% 
% subplot(1,3,2)
% imshow(noise_image,[])
% 
% subplot(1,3,3)
% imshow(I)
