function [sigma] = FWHM2sigma(FWHM)
sigma = FWHM / sqrt(2*log(2));
end

