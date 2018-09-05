
% Description:
% The code illustrates\explaines the appearance of lower lobes in the
% DP experiments due to a delibaretly-made beam curvatue! 


%% Work space
clear all; close all; clc

%% Colormap

x=linspace(0,1,256);
r = sqrt(x);
g = x.^3.0;
b=sin(x*2*pi);
b(b<0)=0;
map = [r;g;b]';

%% PATH
 
matlab_path = 'ADD YOUR PATH TO THE DATA HERE' ;
addpath(matlab_path);
 
%% H5 read

file = uigetfile([matlab_path '*.h5']);
h5disp(file); 
I = h5read(file,'/dataset_1');
I = double(I) ;
I = rot90(I) ;
Phi = h5read(file,'/dataset_2');
Phi = double(Phi) ;
Phi = rot90(Phi) ;


%% Wave field 

% Appends      : KOAS = on ,
%              , Astig. = 15mm ,
%               , f = 2m , 
%               , resolution @ focus = 2.52 micron =>
%               , resolution @ Pinhole plate = 5.57 micron =>
%               , resolution @ Detector = 13.6 micron (close to the real value!)
 

% Preparation and plot

lambda = 13.5e-9;
k = 2*pi/lambda ;
Nx = size(I,1) ;
Ny = size(I,2) ;
dx1 = h5read(file,'/dataset_3');
dy1 = h5read(file,'/dataset_4') ;
z = 2 ;
z = double(z) ;
R = 1e3;
RR = 1e6 ;


[X1,Y1] = meshgrid(((1:Nx)-floor(Nx/2)-1)*dx1,((1:Ny)-floor(Ny/2)-1)*dy1);
X1_axis = ((1:Nx)-floor(Nx/2)-1)*dx1;
Y1_axis = ((1:Ny)-floor(Ny/2)-1)*dy1;


Psi = sqrt(I) .* exp(1i*Phi) .* Bfactor(z,k,X1,Y1) ;
imagesc(RR*X1_axis,RR*Y1_axis,I)
xlabel('\it{\mum}'),ylabel('\it{\mum}')
title(['Intensity @ nominal focus of KAOS',' ','Resolution = 2.52\mum'])
xlim([-50 50]),ylim([-50 50])
%% Propagation to Pinhole-plate

figure;
Dz = 1.067 ; 
M = 1 ;

dx2 = lambda*abs(Dz)/(Nx*dx1);
dy2 = lambda*abs(Dz)/(Ny*dy1);
  % 2D grid
[X2,Y2] = meshgrid(((1:Nx)-floor(Nx/2)-1)*dx2,((1:Ny)-floor(Ny/2)-1)*dy2);
X2_axis = ((1:Nx)-floor(Nx/2)-1)*dx2;
Y2_axis = ((1:Ny)-floor(Ny/2)-1)*dy2;
 
Qx = R*X2_axis(end) ;
Qy = R*Y2_axis(end) ;
  
E_prop = fourier2D(Psi.*Bfactor(Dz,k,X1,Y1)) ;
I_prop = abs(E_prop).^2 ;
I_prop = norm_function(I_prop) ;
imagesc(R*X2_axis,R*Y2_axis,I_prop),zoom(1),colormap(map)
xlim([-Qx/M Qx/M]),ylim([-Qy/M Qy/M])
xlabel('\it{mm}'),ylabel('\it{mm}')
title([num2str(Dz),'m','  ','of the focus',])


%% Aperturing the beam

W = 1.6e-3 ;
E_prop_cut = E_prop .* circ(X2,Y2,W) ; 
I_prop_cut = abs(E_prop_cut).^2 ;
I_prop_cut = norm_function(I_prop_cut) ;
figure;
imagesc(R*X2_axis,R*Y2_axis,I_prop_cut),zoom(1),colormap(map)
xlim([-Qx/M Qx/M]),ylim([-Qy/M Qy/M])
xlabel('\it{mm}'),ylabel('\it{mm}')
title([num2str(Dz),'m','  ','of the focus',' ','with the aperture'])


%% Heading down to detector

alpha = 1 ;
beta = 1 ;
z_1 = 5.78 ;
Rad = 30e-6 ;
Sep = 200e-6 ;
Pinhole_1 = circ(X2-Sep/2,Y2,Rad) ; % upper pinhole
Pinhole_2 = circ(X2+Sep/2,Y2,Rad) ; % lower pinhole

dx3 = lambda*abs(z_1)/(Nx*dx2);
dy3 = lambda*abs(z_1)/(Ny*dy2);
[X3,Y3] = meshgrid(((1:Nx)-floor(Nx/2)-1)*dx3,((1:Ny)-floor(Ny/2)-1)*dy3);
X3_axis = ((1:Nx)-floor(Nx/2)-1)*dx3;
Y3_axis = ((1:Ny)-floor(Ny/2)-1)*dy3;

% First case : A planar (flat) beam shines the pinholes

E_prop_num_flat =  E_prop_cut  ;

Struct_1_f = E_prop_num_flat .* alpha .* Pinhole_1 ;
Struct_2_f = E_prop_num_flat .* beta  .* Pinhole_2 ;

Amp_dif_1_f =  fourier2D(Struct_1_f .* Bfactor(z_1,k,X2,Y2)) ;
Amp_dif_2_f =  fourier2D(Struct_2_f .* Bfactor(z_1,k,X2,Y2)) ;


% I assum I_dif_tota_* = I_dif_1_* + I_dif_2_* + I_dif_int_*
% since I_dif_tot = |Amp_dif_1 + Amp_dif_2|^2 (Amp_dif_* is a Vector!).
% I_dif_int would behave as a cosine function A_0 * Cos(k*(r_1 -  r_2)).
% r_* presents the postional vector!

I_dif_1_f = abs(Amp_dif_1_f).^2 ;
I_dif_2_f = abs(Amp_dif_2_f).^2 ;
I_dif_tot_f = abs(Amp_dif_1_f + Amp_dif_2_f).^2 ;
I_dif_int_f = I_dif_tot_f - (I_dif_1_f + I_dif_2_f) ;

% Second case : A Divergent beam shines the pinholes

E_prop_num_Div = Bfactor(Dz,k,X2,Y2) .*  E_prop_cut  ;

Struct_1_D = E_prop_num_Div .* alpha .* Pinhole_1 ;
Struct_2_D = E_prop_num_Div .* beta  .* Pinhole_2 ;

Amp_dif_1_D =  fourier2D(Struct_1_D .* Bfactor(z_1,k,X2,Y2)) ;
Amp_dif_2_D =  fourier2D(Struct_2_D .* Bfactor(z_1,k,X2,Y2)) ;

I_dif_1_D = abs(Amp_dif_1_D).^2 ;
I_dif_2_D = abs(Amp_dif_2_D).^2 ;
I_dif_tot_D = abs(Amp_dif_1_D + Amp_dif_2_D).^2 ;
I_dif_int_D = I_dif_tot_D - (I_dif_1_D + I_dif_2_D) ;


% An early comparison :
% We compare the non-interfering intensities for both cases.
% Does the curvature chnage the intensity? S_I_residue_* answers!

I_residue_1 = I_dif_1_f - I_dif_1_D ;
I_residue_2 = I_dif_2_f - I_dif_2_D ;

S_I_residue_1 = sum(I_residue_1(:))/(Nx*Ny) ;
S_I_residue_2 = sum(I_residue_2(:))/(Nx*Ny) ;
S_I_dif_tot_f = sum(I_dif_tot_f(:))/(Nx*Ny) ;

fprintf('Residue_1/Pix compared with Total Photon/Pix :%3f\n',(S_I_residue_1/S_I_dif_tot_f))
fprintf('Residue_2/Pix compared with Total Photon/Pix:%3f\n',(S_I_residue_2/S_I_dif_tot_f))

%% Notice

% So, the residues are very small!
% the bet is on the interfering part!

%%

% The interference part is compared!

figure;
plot(R*X3_axis,I_dif_int_f(Nx/2,:),'r'), hold on,
plot(R*X3_axis,I_dif_int_D(Nx/2,:),'b-'), hold off



%% The reason in words

% I_dif_1_* and I_dif_2_* are almost the same. The beam divergence affects 
% the interfernce part. The modulated interference would vary in a range 
% of [-2.I_1.I_2 2.I_1.I_2], but, apparantely, in the second case (blue lines) it does
% not. Therefore, the lower-side lobes of I_dif_tot (not necessarily symmetric) appear.
% Hence, the interference part could be expressed as 
% I_dif_int = 2.I_1.I_2.FACTOR.Cos(...).
%Here, FACTOR addresses the divergent characteristic of the beam. Clearly,
% FACTOR differs from GAMMA of partial coherence. The source was supposed
% to be fully coherent and GAMMA = 1 in all above commands. The Otherwise 
% needs a more complex treatment. 


%% Feel free to add yours!










