function Gprofile = GAUSS(x,y,sigma)

Gprofile = (1/(2*pi*sigma)) * exp(-(x.^2+y.^2)/(2*sigma^2)) ;

end