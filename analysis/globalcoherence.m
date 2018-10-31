function [zeta] = globalcoherence(xi,sigma_B)
zeta = (xi / sigma_B) / sqrt( 4 + (xi / sigma_B)^2 );
end
