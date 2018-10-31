function [J] = ifourier2D(I)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%J = fft2(ifftshift(fft2(I)));
J = fftshift(ifft2(ifftshift(I)));

end

