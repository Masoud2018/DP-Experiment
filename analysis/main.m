%% main
% script to apply the blind-deconvolution algorithm 'deconvblind' of MATLAB on interference patterns of double pinholes taken at FLASH2 in November 2017

%%
clear all;
close all;

%% remarks:

% # global degree of coherence

% from Bagschick+2016 (oe-24-20-23162) eq.5:
% zeta = (xi / sigma_B) * ( 4 + (xi / sigma_B)^2 )^(-1/2)


%% paths of processed files from jupyter script, pinhole separations, etc ...

% path to where the folders with the *.mat files are stored, containing
% averages of the XUV PIXIS images and optical cameras of the fluorecent
% screen around the double pinholes:
datapath = 'C:/Users/Thomas/OneDrive/PhD/coherence/data/11004861/processed/';  
%datapath = '/asap3/flash/gpfs/fl24/2017/data/11004861/processed/'; % approx. 1GB
% some folders have very long filenames (might be a problem under windows)

% naming conventions:
% vertically: a,b / horizontally: c,d
% suffix: '_L' : larger beam of around 2mm FWHM
% suffix: '_S' : smaller beam of around 1mm FWHM

% un-comment the lines that load the pinhole-pair you want to process

% pixis_centerx_px and pixis_centery_px are the coordinates of the peak of
% the interference pattern

% Sigma_um_min and Sigma_um_max define the range where a loop should
% be done if run_sigma_scan = true. (To find the Sigma_um where the deconvolved pattern 'touches' the zero.
% Else, the value Sigma_um will be used to only plot one value


run_sigma_scan = true;
%run_sigma_scan = false;


%%% 2017-11-24T2020 13.5nm 68uJ 7Und. KOAS=1.5mm
% vertically:
%wavelength_nm = 13.5; pixis_centerx_px = 529; pixis_centery_px = 483; Sigma_um = 35; d_um = 322; load(strcat(datapath,'2017-11-24T2020 13.5nm 68uJ 7Und. KOAS=1.5mm 0322um (4a) ap5=7.0 ap7=50.0 2017-11-24T1309 13.5nm 68uJ 7Und. KOAS=PMMA (bg4ab)/FLASH2_USER1-2017-11-24T2020.h5_ph_4a_d_322.0_E_047.23_average.mat')); 
%wavelength_nm = 13.5; pixis_centerx_px = 500; pixis_centery_px = 480; Sigma_um = 45; d_um = 707; load(strcat(datapath,'2017-11-24T2020 13.5nm 68uJ 7Und. KOAS=1.5mm 0707um (1b) ap5=7.0 ap7=50.0 2017-11-24T1309 13.5nm 68uJ 7Und. KOAS=PMMA (bg1ab)/FLASH2_USER1-2017-11-24T2020.h5_ph_1b_d_707.0_E_046.69_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 595; pixis_centery_px = 520; Sigma_um = 70; d_um = 890; load(strcat(datapath,'2017-11-24T2020 13.5nm 68uJ 7Und. KOAS=1.5mm 0890um (2b#2) ap5=7.0 ap7=50.0 (bg2bc)/FLASH2_USER1-2017-11-24T2020.h5_ph_2b#2_d_890.0_E_047.10_average.mat'));
% horizontally:
%wavelength_nm = 13.5; pixis_centerx_px = 455; pixis_centery_px = 555; Sigma_um = 30; d_um = 322; load(strcat(datapath,'2017-11-24T2020 13.5nm 68uJ 7Und. KOAS=1.5mm 0322um (4c) ap5=7.0 ap7=50.0 2017-11-24T1309 13.5nm 68uJ 7Und. KOAS=PMMA (bg4ab)/FLASH2_USER1-2017-11-24T2020.h5_ph_4c_d_322.0_E_041.61_average.mat'));


%%% 2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm
% vertically:
% negative values ... wavelength_nm = 18.0; pixis_centerx_px = 550; pixis_centery_px = 505; Sigma_um = 20; d_um = 107; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0107um (2a) ap5=7.0 ap7=50.0 (bg2ab)/FLASH2_USER1-2017-11-25T0141.h5_ph_2a_d_107.0_E_055.48_average.mat'));
% negative values ... wavelength_nm = 18.0; pixis_centerx_px = 567; pixis_centery_px = 445; Sigma_um = 12; d_um = 215; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0215um (3a#1) ap5=7.0 ap7=50.0 (bg3ab#1)/FLASH2_USER1-2017-11-25T0141.h5_ph_3a#1_d_215.0_E_059.72_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 552; pixis_centery_px = 502; Sigma_um = 30; d_um = 322; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0322um (4a) ap5=7.0 ap7=50.0 (bg4cd)/FLASH2_USER1-2017-11-25T0141.h5_ph_4a_d_322.0_E_054.27_average.mat'));
%wavelength_nm = 18.0; ???pixis_centerx_px = 500; pixis_centery_px = 550; Sigma_um = 35; d_um = 707; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0707um (1b) ap5=7.0 ap7=50.0 (bg1ab)/FLASH2_USER1-2017-11-25T0141.h5_ph_1b_d_707.0_E_058.65_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 530; pixis_centery_px = 550; Sigma_um = 39; d_um = 890; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0890um (2b) ap5=7.0 ap7=50.0 (bg2ab)/FLASH2_USER1-2017-11-25T0141.h5_ph_2b_d_890.0_E_062.71_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 600; pixis_centery_px = 460; Sigma_um = 39; d_um = 1047; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 1047um (3b#1) ap5=7.0 ap7=50.0 (bg3ab#1)/FLASH2_USER1-2017-11-25T0141.h5_ph_3b#1_d_1047.0_E_052.28_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 600; pixis_centery_px = 460; Sigma_um = 39; d_um = 1047; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 1047um (3b#1) ap5=7.0 ap7=50.0 (bg3ab#2)/FLASH2_USER1-2017-11-25T0141.h5_ph_3b#1_d_1047.0_E_052.28_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 600; pixis_centery_px = 460; Sigma_um = 39; d_um = 1047; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 1047um (3b#2) ap5=7.0 ap7=50.0 (bg3ab#1)/FLASH2_USER1-2017-11-25T0141.h5_ph_3b#2_d_1047.0_E_055.74_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 600; pixis_centery_px = 460; Sigma_um = 39; d_um = 1047; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 1047um (3b#2) ap5=7.0 ap7=50.0 (bg3ab#2)/FLASH2_USER1-2017-11-25T0141.h5_ph_3b#2_d_1047.0_E_055.74_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 500; pixis_centery_px = 510; Sigma_um = 48; d_um = 1335; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 1335um (4b) ap5=7.0 ap7=50.0 (bg4cd)/FLASH2_USER1-2017-11-25T0141.h5_ph_4b_d_1335.0_E_068.35_average.mat'));
% horizontally:
%wavelength_nm = 18.0; pixis_centerx_px = 526; pixis_centery_px = 559; Sigma_um = 20; d_um = 107; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0107um (2c) ap5=7.0 ap7=50.0 (bg2ab)/FLASH2_USER1-2017-11-25T0141.h5_ph_2c_d_107.0_E_048.18_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 463; pixis_centery_px = 570; Sigma_um = 30; d_um = 322; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0322um (4c) ap5=7.0 ap7=50.0 (bg4cd)/FLASH2_USER1-2017-11-25T0141.h5_ph_4c_d_322.0_E_055.30_average.mat'));
%%% negative values wavelength_nm = 18.0; pixis_centerx_px = 500; pixis_centery_px = 550; Sigma_um = 30; d_um = 707; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0707um (1d) ap5=7.0 ap7=50.0 (bg1ab)/FLASH2_USER1-2017-11-25T0141.h5_ph_1d_d_707.0_E_053.83_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 530; pixis_centery_px = 570; Sigma_um = 35; d_um = 890; load(strcat(datapath,'2017-11-25T0141 18.0nm 46uJ 7Und. KOAS=1.5mm 0890um (2d) ap5=7.0 ap7=50.0 (bg2ab)/FLASH2_USER1-2017-11-25T0141.h5_ph_2d_d_890.0_E_052.28_average.mat'));


%%% 2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA
% vertically: FWHM approx 3mm
wavelength_nm = 18.0; pixis_centerx_px = 444; pixis_centery_px = 552; Sigma_um = 39; Sigma_um_min=35; Sigma_um_max=42; d_um = 107; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0107um (2a) ap5=7.0 ap7=50.0 (bg2ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_2a_d_107.0_E_048.17_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 424; pixis_centery_px = 499; Sigma_um = 25; Sigma_um_min=10; Sigma_um_max=35; d_um = 215; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0215um (3a) ap5=7.0 ap7=50.0 (bg3a#1) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_3a_d_215.0_E_047.84_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 398; pixis_centery_px = 496; Sigma_um = 22; Sigma_um_min=18; Sigma_um_max=35; d_um = 322; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0322um (4a) ap5=7.0 ap7=50.0 (bg4cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_4a_d_322.0_E_047.82_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 448; pixis_centery_px = 489; Sigma_um = 27; Sigma_um_min=18; Sigma_um_max=35; d_um = 707; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0707um (1b) ap5=7.0 ap7=50.0 (bg1ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_1b_d_707.0_E_047.97_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 425; pixis_centery_px = 556; Sigma_um = 22; Sigma_um_min=18; Sigma_um_max=35; d_um = 890; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0890um (2b) ap5=7.0 ap7=50.0 (bg2ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_2b_d_890.0_E_048.17_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 355; pixis_centery_px = 500; Sigma_um = 23; Sigma_um_min=20; Sigma_um_max=35; d_um = 1047; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 1047um (3b) ap5=7.0 ap7=50.0 (bg3ab#2) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_3b_d_1047.0_E_047.92_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 493; pixis_centery_px = 500; Sigma_um = 21; Sigma_um_min=20; Sigma_um_max=35; d_um = 1335; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 1335um (4b) ap5=7.0 ap7=50.0 (bg4cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_4b_d_1335.0_E_047.91_average.mat'));
d_um_26T2300_18nm_ver_L = [ 107, 215, 322, 707, 890, 1047, 1335 ];
d_FWHM_26T2300_18nm_ver_L = d_um_26T2300_18nm_ver_L / 2400;
xi_um_26T2300_18nm_ver_L = [ 455.3644, 680.2117, 780.5904, 794.6978, 779.6730, 1.0671e+03, 802.8734 ];
for i=1:length(xi_um_26T2300_18nm_ver_L)
    zeta_26T2300_18nm_ver_L(i) = globalcoherence(xi_um_26T2300_18nm_ver_L(i), FWHM2sigma(2400));
end

% horizontally:  FWHM approx 2mm
%wavelength_nm = 18.0; pixis_centerx_px = 450; pixis_centery_px = 437; Sigma_um = 58; Sigma_um_min=55; Sigma_um_max=65;  d_um = 107; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0107um (2c) ap5=7.0 ap7=50.0 (bg2ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_2c_d_107.0_E_048.16_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 441; pixis_centery_px = 433; Sigma_um = 19; Sigma_um_min=15; Sigma_um_max=25; d_um = 215; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0215um (3c) ap5=7.0 ap7=50.0 (bg3a#2) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_3c_d_215.0_E_047.93_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 465; pixis_centery_px = 431; Sigma_um = 19; Sigma_um_min=15; Sigma_um_max=23; d_um = 322; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0322um (4c) ap5=7.0 ap7=50.0 (bg4cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_4c_d_322.0_E_047.88_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 502; pixis_centery_px = 429; Sigma_um = 17; Sigma_um_min=13; Sigma_um_max=35; d_um = 890; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 0890um (2d) ap5=7.0 ap7=50.0 (bg2ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_2d_d_890.0_E_048.06_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 493; pixis_centery_px = 430; Sigma_um = 15; Sigma_um_min=10; Sigma_um_max=20; d_um = 1047; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 1047um (3d) ap5=7.0 ap7=50.0 (bg3ab#1) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_3d_d_1047.0_E_047.86_average.mat'));
%%% chopered data! pixis_centerx_px = 470; pixis_centery_px = 430; Sigma_um = 15; Sigma_um_min=10; Sigma_um_max=35; d_um = 1335; load(strcat(datapath,'2017-11-26T1916 18.0nm 70uJ 7Und. KOAS=PMMA 1335um (4d) ap5=7.0 ap7=50.0 (bg4cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T1916.h5_ph_4d_d_1335.0_E_047.92_average.mat'));
d_um_26T2300_18nm_hor_L = [ 107, 215, 322, 890, 1047 ];
d_FWHM_26T2300_18nm_hor_L = d_um_26T2300_18nm_hor_L / 2400;
xi_um_26T2300_18nm_hor_L = [ 332.2753, 922.0736, 904.3329, 1.0239e+03, 1.1251e+03 ];

for i=1:length(xi_um_26T2300_18nm_hor_L)
    zeta_26T2300_18nm_hor_L(i) = globalcoherence(xi_um_26T2300_18nm_hor_L(i), FWHM2sigma(2400));
end



%%% 2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm
% vertically: 
%wavelength_nm = 18.0; pixis_centerx_px = 455; pixis_centery_px = 487; Sigma_um = 63; d_um = 50;  Sigma_um_min=58; Sigma_um_max=66; load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0050um (1a) ap5=7.0 ap7=1.5 (bg1ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_1a_d_50.0_E_047.74_average.mat'));
%%%wavelength_nm = 18.0; pixis_centerx_px = 453; pixis_centery_px = 490; Sigma_um = 36; d_um = 107; Sigma_um_min=35; Sigma_um_max=50; load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0107um (2a) ap5=7.0 ap7=50.0 (bg2ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T2300.h5_ph_2a_d_107.0_E_047.87_average.mat'));
%%%wavelength_nm = 18.0; pixis_centerx_px = 438; pixis_centery_px = 444; Sigma_um = 30; d_um = 215; Sigma_um_min=26; Sigma_um_max=33;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0215um (3a) ap5=7.0 ap7=50.0 (bg3ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_3a_d_215.0_E_047.79_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 435; pixis_centery_px = 452; Sigma_um = 35; d_um = 322; Sigma_um_min=30; Sigma_um_max=38;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0322um (4a) ap5=7.0 ap7=1.5 (bg4ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_4a_d_322.0_E_047.64_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 476; pixis_centery_px = 488; Sigma_um = 43; d_um = 445; Sigma_um_min=39; Sigma_um_max=46;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0445um (5a) ap5=7.0 ap7=1.5 (bg5ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_5a_d_445.0_E_047.64_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 455; pixis_centery_px = 472; Sigma_um = 51; d_um = 707; Sigma_um_min=38; Sigma_um_max=55;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0707um (1b) ap5=7.0 ap7=1.5 (bg1ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_1b_d_707.0_E_047.84_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 374; pixis_centery_px = 483; Sigma_um = 39; d_um = 890; Sigma_um_min=25; Sigma_um_max=55;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0890um (2b) ap5=7.0 ap7=50.0 (bg2ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T2300.h5_ph_2b_d_890.0_E_047.93_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 500; pixis_centery_px = 400; Sigma_um = 36; d_um = 1047; Sigma_um_min=30; Sigma_um_max=40;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 1047um (3b) ap5=7.0 ap7=1.5 (bg3ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_3b_d_1047.0_E_047.78_average.mat'));
d_um_26T2300_18nm_ver_S = [ 50, 107, 215, 322, 445, 707, 890, 1047 ];
d_FWHM_26T2300_18nm_ver_S = d_um_26T2300_18nm_ver_S / (2400/2);
xi_um_26T2300_18nm_ver_S = [ 266.7286,  467.7301, 564.8696, 477.9354, 386.9892, 328.1238, 427.3350, 470.8618 ];

for i=1:length(xi_um_26T2300_18nm_ver_S)
    zeta_26T2300_18nm_ver_S(i) = globalcoherence(xi_um_26T2300_18nm_ver_S(i), FWHM2sigma(2400/2));
end

% horizontally:
%wavelength_nm = 18.0; pixis_centerx_px = 474; pixis_centery_px = 493; Sigma_um = 57; d_um = 50; Sigma_um_min=50; Sigma_um_max=60;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0050um (1c#2) ap5=7.0 ap7=1.5 (bg1ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_1c#2_d_50.0_E_047.74_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 522; pixis_centery_px = 494; Sigma_um = 25; d_um = 215; Sigma_um_min=20; Sigma_um_max=30;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0215um (3c) ap5=7.0 ap7=1.5 (bg3ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_3c_d_215.0_E_047.70_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 477; pixis_centery_px = 488; Sigma_um = 36; d_um = 322; Sigma_um_min=30; Sigma_um_max=40;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0322um (4c) ap5=7.0 ap7=1.5 (bg4ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_4c_d_322.0_E_047.83_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 418; pixis_centery_px = 472; Sigma_um = 26; d_um = 445; Sigma_um_min=22; Sigma_um_max=30;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0445um (5c) ap5=7.0 ap7=1.5 (bg5ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_5c_d_445.0_E_047.90_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 374; pixis_centery_px = 476; Sigma_um = 23; d_um = 707; Sigma_um_min=20; Sigma_um_max=26;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0707um (1d#2) ap5=7.0 ap7=1.5 (bg1ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_1d#2_d_707.0_E_047.84_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 374; pixis_centery_px = 467; Sigma_um = 27; d_um = 890; Sigma_um_min=10; Sigma_um_max=35;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 0890um (2d) ap5=7.0 ap7=50.0 (bg2ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-26T2300.h5_ph_2d_d_890.0_E_047.88_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 530; pixis_centery_px = 490; Sigma_um = 21; d_um = 1047; Sigma_um_min=15; Sigma_um_max=35;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 1047um (3d) ap5=7.0 ap7=1.5 (bg3ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_3d_d_1047.0_E_047.67_average.mat'));
%wavelength_nm = 18.0; pixis_centerx_px = 530; pixis_centery_px = 450; Sigma_um = 19; d_um = 1335; Sigma_um_min=15; Sigma_um_max=23;  load(strcat(datapath,'2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm 1335um (4d) ap5=7.0 ap7=1.5 (bg4ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-26T2300.h5_ph_4d_d_1335.0_E_047.80_average.mat'));
d_um_26T2300_18nm_hor_S = [ 50, 215, 322, 445, 707, 890, 1047, 1335 ];
d_FWHM_26T2300_18nm_hor_S = d_um_26T2300_18nm_hor_S / (2400/2);
xi_um_26T2300_18nm_hor_S = [ 313.1795, 680.4464, 471.8095, 650.6023, 729.7264, 625.6716, 802.7694, 886.0035 ];

for i=1:length(xi_um_26T2300_18nm_hor_S)
    zeta_26T2300_18nm_hor_S(i) = globalcoherence(xi_um_26T2300_18nm_hor_S(i), FWHM2sigma(2400/2));
end



%%% 2017-11-27T1101 8.0nm 45uJ 12Und. KOAS=_mm 
%%% THIS is actually at the PMMA focus!
% vertically:
%wavelength_nm = 8.0; pixis_centerx_px = 534; pixis_centery_px = 436; Sigma_um = 25; Sigma_um_min=10; Sigma_um_max=35; d_um = 107; load(strcat(datapath,'2017-11-27T1101 8.0nm 45uJ 12Und. KOAS=_mm 0107um (2a#2-Nb197) ap5=7.0 ap7=50.0 (bg2ab-Nb197)/FLASH2_USER1-2017-11-27T1101.h5_ph_2a#2_d_107.0_E_040.04_average.mat'));
%wavelength_nm = 8.0; pixis_centerx_px = 508; pixis_centery_px = 410; Sigma_um = 24; Sigma_um_min=10; Sigma_um_max=35; d_um = 322; load(strcat(datapath,'2017-11-27T1101 8.0nm 45uJ 12Und. KOAS=_mm 0322um (4a-none) ap5=7.0 ap7=50.0 (bg3cd-none)/FLASH2_USER1-2017-11-27T1101.h5_ph_4a_d_322.0_E_041.64_average.mat'));
d_um_27T1529_8nm_ver_L = [ 107, 322 ];
d_FWHM_27T1529_8nm_ver_L = d_um_27T1529_8nm_ver_L / 2100;
xi_um_27T1529_8nm_ver_L = [ 311.2682, 307.6950 ];

for i=1:length(xi_um_27T1529_8nm_ver_L)
    zeta_27T1529_8nm_ver_L(i) = globalcoherence(xi_um_27T1529_8nm_ver_L(i), FWHM2sigma(2100));
end

% horizontally:
%wavelength_nm = 8.0; pixis_centerx_px = 524; pixis_centery_px = 488; Sigma_um = 24; Sigma_um_min=20; Sigma_um_max=30; d_um = 107; load(strcat(datapath,'2017-11-27T1101 8.0nm 45uJ 12Und. KOAS=_mm 0107um (2c-Nb197) ap5=7.0 ap7=50.0 (bg2ab-Nb197)/FLASH2_USER1-2017-11-27T1101.h5_ph_2c_d_107.0_E_041.38_average.mat'));
%wavelength_nm = 8.0; pixis_centerx_px = 685; pixis_centery_px = 490; Sigma_um = 16; Sigma_um_min=10; Sigma_um_max=35; d_um = 215; load(strcat(datapath,'2017-11-27T1101 8.0nm 45uJ 12Und. KOAS=_mm 0215um (3c#1-none) ap5=7.0 ap7=50.0 (bg3cd-none)/FLASH2_USER1-2017-11-27T1101.h5_ph_3c#1_d_215.0_E_037.60_average.mat'));
%wavelength_nm = 8.0; pixis_centerx_px = 570; pixis_centery_px = 480; Sigma_um = 13; Sigma_um_min=10; Sigma_um_max=35; d_um = 890; load(strcat(datapath,'2017-11-27T1101 8.0nm 45uJ 12Und. KOAS=_mm 0890um (2d#1-Nb197) ap5=7.0 ap7=50.0 (bg2ab-Nb197)/FLASH2_USER1-2017-11-27T1101.h5_ph_2d#1_d_890.0_E_039.84_average.mat'));
d_um_27T1529_8nm_hor_L = [ 107, 215, 890 ];
d_FWHM_27T1529_8nm_hor_L = d_um_27T1529_8nm_hor_L / 1700;
xi_um_27T1529_8nm_hor_L = [ 351.0928, 497.5362, 702.4303 ];

for i=1:length(xi_um_27T1529_8nm_hor_L)
    zeta_27T1529_8nm_hor_L(i) = globalcoherence(xi_um_27T1529_8nm_hor_L(i), FWHM2sigma(1700));
end



%%% 2017-11-27T1529 8.0nm 45uJ 12Und. KOAS=PMMA
%%% This is actually the smaller beam!
% vertically:
%wavelength_nm = 8.0; pixis_centerx_px = 561; pixis_centery_px = 460; Sigma_um = 30; Sigma_um_min=10; Sigma_um_max=35; d_um = 215; load(strcat(datapath,'2017-11-27T1529 8.0nm 45uJ 12Und. KOAS=PMMA 0215um (3a#1) ap5=7.0 ap7=50.0 (bg3cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-27T1529.h5_ph_3a#1_d_215.0_E_041.32_average.mat'));
%wavelength_nm = 8.0; pixis_centerx_px = 533; pixis_centery_px = 441; Sigma_um = 27; Sigma_um_min=10; Sigma_um_max=40; d_um = 322; load(strcat(datapath,'2017-11-27T1529 8.0nm 45uJ 12Und. KOAS=PMMA 0322um (4a) ap5=7.0 ap7=50.0 (bg3cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-27T1529.h5_ph_4a_d_322.0_E_039.39_average.mat'));
%wavelength_nm = 8.0; pixis_centerx_px = 459; pixis_centery_px = 438; Sigma_um = 41; Sigma_um_min=15; Sigma_um_max=50; d_um = 445; load(strcat(datapath,'2017-11-27T1529 8.0nm 45uJ 12Und. KOAS=PMMA 0445um (5a) ap5=7.0 ap7=50.0 (bg5ab) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-27T1529.h5_ph_5a_d_445.0_E_042.36_average.mat'));
%wavelength_nm = 8.0; pixis_centerx_px = 500; pixis_centery_px = 454; Sigma_um = 43; Sigma_um_min=30; Sigma_um_max=60; d_um = 707; load(strcat(datapath,'2017-11-27T1529 8.0nm 45uJ 12Und. KOAS=PMMA 0707um (1b) ap5=7.0 ap7=50.0 (bg1cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-27T1529.h5_ph_1b_d_707.0_E_040.86_average.mat'));
d_um_27T1529_8nm_ver_S = [ 215, 322, 445, 707 ];
d_FWHM_27T1529_8nm_ver_S = d_um_27T1529_8nm_ver_S / (2100/2);
xi_um_27T1529_8nm_ver_S = [ 247.6399, 273.6594, 180.0854, 171.7345 ];
for i=1:length(xi_um_27T1529_8nm_ver_S)
    zeta_27T1529_8nm_ver_S(i) = globalcoherence(xi_um_27T1529_8nm_ver_S(i), FWHM2sigma(2100/2));
end

% horizontally:
%wavelength_nm = 8.0; pixis_centerx_px = 557; pixis_centery_px = 529; Sigma_um = 20; Sigma_um_min=10; Sigma_um_max=35; d_um = 215; load(strcat(datapath,'2017-11-27T1529 8.0nm 45uJ 12Und. KOAS=PMMA 0215um (3c) ap5=7.0 ap7=50.0 (bg3cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-27T1529.h5_ph_3c_d_215.0_E_039.98_average.mat'));
%wavelength_nm = 8.0; pixis_centerx_px = 421; pixis_centery_px = 509; Sigma_um = 23; Sigma_um_min=10; Sigma_um_max=35; d_um = 445; load(strcat(datapath,'2017-11-27T1529 8.0nm 45uJ 12Und. KOAS=PMMA 0445um (5c) ap5=7.0 ap7=50.0 (bg5ab) ap5=7.0 ap7=50.0  /FLASH2_USER1-2017-11-27T1529.h5_ph_5c_d_445.0_E_042.04_average.mat'));
%wavelength_nm = 8.0; pixis_centerx_px = 501; pixis_centery_px = 528; Sigma_um = 21; Sigma_um_min=10; Sigma_um_max=35; d_um = 707; load(strcat(datapath,'2017-11-27T1529 8.0nm 45uJ 12Und. KOAS=PMMA 0707um (1d) ap5=7.0 ap7=50.0 (bg1cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-27T1529.h5_ph_1d_d_707.0_E_040.91_average.mat'));
d_um_27T1529_8nm_hor_S = [ 215, 445, 707 ];
d_FWHM_27T1529_8nm_hor_S = d_um_27T1529_8nm_hor_S / (1700/2);
xi_um_27T1529_8nm_hor_S = [ 373.8574, 321.9275, 352.4699 ];
for i=1:length(xi_um_27T1529_8nm_hor_S)
    zeta_27T1529_8nm_hor_S(i) = globalcoherence(xi_um_27T1529_8nm_hor_S(i), FWHM2sigma(1700/2));
end



%%% 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm
% vertically:
% bg?? wavelength_nm = 13.5; pixis_centerx_px = 556; pixis_centery_px = 500; Sigma_um = 35; Sigma_um_min=10; Sigma_um_max=40; d_um = 50; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0050um (1a#1) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm (bg1cd) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_1a#1_d_50.0_E_112.94_average.mat')); 
% bg?? wavelength_nm = 13.5; pixis_centerx_px = 506; pixis_centery_px = 465; Sigma_um = 12; Sigma_um_min=10; Sigma_um_max=55; d_um = 107; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0107um (2a#1) ap5=7.0 ap7=50.0.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg2ab#1) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_2a#1_d_107.0_E_103.10_average.mat')); 
%wavelength_nm = 13.5; pixis_centerx_px = 545; pixis_centery_px = 470; Sigma_um = 36; Sigma_um_min=10; Sigma_um_max=40; d_um = 107; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0107um (2a#2) ap5=8.8 ap7=3.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm (bg2ab#2) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_2a#2_d_107.0_E_111.65_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 555; pixis_centery_px = 530; Sigma_um = 31; Sigma_um_min=15; Sigma_um_max=40; d_um = 215; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0215um (3a#1) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_3a#1_d_215.0_E_111.12_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 549; pixis_centery_px = 500; Sigma_um = 28; Sigma_um_min=15; Sigma_um_max=40; d_um = 215; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0215um (3a#2) ap5=8.8 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_3a#2_d_215.0_E_108.12_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 486; pixis_centery_px = 520; Sigma_um = 37; Sigma_um_min=15; Sigma_um_max=40; d_um = 322; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0322um (4a#1) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_4a#1_d_322.0_E_107.45_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 526; pixis_centery_px = 523; Sigma_um = 37; Sigma_um_min=15; Sigma_um_max=40; d_um = 322; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0322um (4a#2) ap5=8.8 ap7=3.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_4a#2_d_322.0_E_110.23_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 556; pixis_centery_px = 500; Sigma_um = 27; Sigma_um_min=15; Sigma_um_max=40; d_um = 707; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0707um (1b#1) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm (bg1cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-29T1007.h5_ph_1b#1_d_707.0_E_112.92_average.mat'));
d_um_29T1007_13p5nm_ver_S = [ 107, 215, 215, 322, 322, 707 ];
d_FWHM_29T1007_13p5nm_ver_S = d_um_29T1007_13p5nm_ver_S / (1960/2);
xi_um_29T1007_13p5nm_ver_S = [ 350.5551, 403.8876, 445.4800, 345.4695, 345.1456, 339.1556 ];

for i=1:length(xi_um_29T1007_13p5nm_ver_S)
    zeta_29T1007_13p5nm_ver_S(i) = globalcoherence(xi_um_29T1007_13p5nm_ver_S(i), FWHM2sigma(1960/2));
end
% horizontally:
%wavelength_nm = 13.5; pixis_centerx_px = 498; pixis_centery_px = 490; Sigma_um = 15; Sigma_um_min=10; Sigma_um_max=25; d_um = 50; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0050um (1c#1) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm (bg1cd) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_1c#1_d_50.0_E_111.73_average.mat')); 
%%%?wavelength_nm = 13.5; pixis_centerx_px = 558; pixis_centery_px = 490; Sigma_um = 23; Sigma_um_min=15; Sigma_um_max=40; d_um = 107; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0107um (2c#1) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg2ab#1) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_2c#1_d_107.0_E_104.53_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 489; pixis_centery_px = 520; Sigma_um = 31; Sigma_um_min=15; Sigma_um_max=40; d_um = 215; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0215um (3c#1) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_3c#1_d_215.0_E_103.47_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 377; pixis_centery_px = 523; Sigma_um = 41; Sigma_um_min=15; Sigma_um_max=40; d_um = 322; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0322um (4c#1) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_4c#1_d_322.0_E_109.30_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 539; pixis_centery_px = 523; Sigma_um = 35; Sigma_um_min=15; Sigma_um_max=40; d_um = 445; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0445um (5c#1) ap5=7.0 ap7=3.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm (bg5cd) ap5=8.8 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_5c#1_d_445.0_E_112.38_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 556; pixis_centery_px = 500; Sigma_um = 33; Sigma_um_min=15; Sigma_um_max=40; d_um = 707; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm 0707um (1d#0) ap5=7.0 ap7=50.0 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm (bg1cd) ap5=7.0 ap7=50.0/FLASH2_USER1-2017-11-29T1007.h5_ph_1d#0_d_707.0_E_106.39_average.mat'));
d_um_29T1007_13p5nm_hor_S = [ 50, 215, 322, 445, 707 ];
d_FWHM_29T1007_13p5nm_hor_S = d_um_29T1007_13p5nm_hor_S / (2060/2);
xi_um_29T1007_13p5nm_hor_S = [ 848.5169, 404.6551, 338.4204, 356.9162, 382.4135 ];
for i=1:length(xi_um_29T1007_13p5nm_hor_S)
    zeta_29T1007_13p5nm_hor_S(i) = globalcoherence(xi_um_29T1007_13p5nm_hor_S(i), FWHM2sigma(2060/2));
end


%%% 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA
% vertically:
%wavelength_nm = 13.5; pixis_centerx_px = 540; pixis_centery_px = 510; Sigma_um = 30; d_um = 107; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0107um (2a#3) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg2ab#1) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_2a#3_d_107.0_E_114.42_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 473; pixis_centery_px = 490; Sigma_um = 22; d_um = 215; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0215um (3a#3) ap5=7.0 ap7=1.5 (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_3a#3_d_215.0_E_111.81_average.mat'));
%??wavelength_nm = 13.5; pixis_centerx_px = 464; pixis_centery_px = 580; Sigma_um = 20; d_um = 322; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0322um (4a#3) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_4a#3_d_322.0_E_105.60_average.mat'));
%??wavelength_nm = 13.5; pixis_centerx_px = 492; pixis_centery_px = 520; Sigma_um = 20; Sigma_um_min=15; Sigma_um_max=22; d_um = 322; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0322um (4a#4) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_4a#4_d_322.0_E_109.94_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 500; pixis_centery_px = 500; Sigma_um = 20; Sigma_um_min=15; Sigma_um_max=28; d_um = 445; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0445um (5a#03) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm (bg5cd) ap5=8.8 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_5a#03_d_445.0_E_109.75_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 500; pixis_centery_px = 500; Sigma_um = 28; Sigma_um_min=15; Sigma_um_max=31; d_um = 707; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0707um (1b) ap5=7.0 ap7=1.5 2017-11-26T2300 13.5nm 111uJ 12Und. KOAS=1.5mm (bg1ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-29T1007.h5_ph_1b#3_d_707.0_E_107.02_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 480; pixis_centery_px = 480; Sigma_um = 29; Sigma_um_min=15; Sigma_um_max=38; d_um = 890; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0890um (2b#1) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg2ab#1) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_2b#3_d_890.0_E_111.31_average.mat'));
%??wavelength_nm = 13.5; pixis_centerx_px = 480; pixis_centery_px = 480; Sigma_um = 22; Sigma_um_min=15; Sigma_um_max=28; d_um = 890; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0890um (2b#2) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg2ab#1) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_2b#4_d_890.0_E_112.95_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 500; pixis_centery_px = 480; Sigma_um = 20; Sigma_um_min=15; Sigma_um_max=35; d_um = 1047; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 1047um (3b#3) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_3b#3_d_1047.0_E_106.60_average.mat'));
FWHM_y_29T1007_13p5nm_ = 1960;
d_um_29T1007_13p5nm_ver_L = [ 215, 445, 707, 890, 890, 1047 ]; 
d_FWHM_29T1007_13p5nm_ver_L = d_um_29T1007_13p5nm_ver_L / FWHM_y_29T1007_13p5nm_;
xi_um_29T1007_13p5nm_ver_L = [ 642.6470, 622.9184, 445.5118, 432.5878, 575.5449, 624.3753];

for i=1:length(xi_um_29T1007_13p5nm_ver_S)
    zeta_29T1007_13p5nm_ver_L(i) = globalcoherence(xi_um_29T1007_13p5nm_ver_S(i), FWHM2sigma(1960));
end
% horizontally:
%wavelength_nm = 13.5; pixis_centerx_px = 532; pixis_centery_px = 550; Sigma_um = 29; d_um = 107; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0107um (2c#2) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg2ab#1) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_2c#2_d_107.0_E_112.92_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 557; pixis_centery_px = 530; Sigma_um = 25; d_um = 215; xi_um=505.1040; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0215um (3c#2) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_3c#2_d_215.0_E_107.29_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 430; pixis_centery_px = 500; Sigma_um = 21; Sigma_um_max = 27; d_um = 322; xi_um=630.3814;load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0322um (4c#2) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_4c#2_d_322.0_E_111.22_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 480; pixis_centery_px = 480; Sigma_um = 20; d_um = 445; xi_um=624.3011; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0445um (5c#2) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=1.5mm (bg5cd) ap5=8.8 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_5c#2_d_445.0_E_113.85_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 480; pixis_centery_px = 520; Sigma_um = 21; d_um = 707; xi_um=569.6138; load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0707um (1d) ap5=7.0 ap7=1.5 2017-11-26T2300 18.0nm 70uJ 7Und. KOAS=1.5mm (bg1ab) ap5=7.0 ap7=1.5/FLASH2_USER1-2017-11-29T1007.h5_ph_1d#2_d_707.0_E_113.17_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 500; pixis_centery_px = 500; Sigma_um = 21; d_um = 890; xi_um=598.1924;load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 0890um (2d#2) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg2ab#1) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_2d#2_d_890.0_E_115.11_average.mat'));
%wavelength_nm = 13.5; pixis_centerx_px = 500; pixis_centery_px = 520; Sigma_um = 27; d_um = 1047; xi_um=463.4609;load(strcat(datapath,'2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA 1047um (3d#2) ap5=7.0 ap7=1.5 2017-11-29T1007 13.5nm 111uJ 12Und. KOAS=PMMA (bg3ab) ap5=7.0 ap7=3.0/FLASH2_USER1-2017-11-29T1007.h5_ph_3d#2_d_1047.0_E_105.38_average.mat'));
FWHM_x_29T1007_13p5nm_ = 2060;
d_um_29T1007_13p5nm_hor_L = [ 215, 322, 445, 707, 890, 1047 ];
d_FWHM_29T1007_13p5nm_hor_L = d_um_29T1007_13p5nm_hor_L / FWHM_x_29T1007_13p5nm_;
xi_um_29T1007_13p5nm_hor_L = [ 505.1040, 630.3814, 624.3011, 569.6138, 598.1924, 463.4609 ];

for i=1:length(xi_um_29T1007_13p5nm_hor_L)
    zeta_29T1007_13p5nm_hor_L(i) = globalcoherence(xi_um_29T1007_13p5nm_hor_L(i), FWHM2sigma(2060));
end


%% plot the coherence length and coherence degree over the pinhole separation
figure('rend', 'painters','pos', [10 10 1000 1000]);

subplot(3,3,1);
plot(d_um_27T1529_8nm_ver_S, xi_um_27T1529_8nm_ver_S, '-xb');
hold on
plot(d_um_27T1529_8nm_hor_S, xi_um_27T1529_8nm_hor_S, '-xr');
hold on
plot(d_um_27T1529_8nm_ver_L, xi_um_27T1529_8nm_ver_L, '-ob');
hold on
plot(d_um_27T1529_8nm_hor_L, xi_um_27T1529_8nm_hor_L, '-or');
hold on
plot([0 1335],[0 1335], ':k');
hold off
ylim([0 1400])
xlabel('separation / um'), ylabel('coherence length \xi / um');
legend('FWHM_x=0.85mm','FWHM_x=1.05mm','FWHM_x=1.70mm','FWHM_x=2.10mm');
title('\lambda=8nm E=45uJ #Undulators=12');

subplot(3,3,4);
plot(d_FWHM_27T1529_8nm_ver_S, xi_um_27T1529_8nm_ver_S, '-xb');
hold on
plot(d_FWHM_27T1529_8nm_hor_S, xi_um_27T1529_8nm_hor_S, '-xr');
hold on
plot(d_FWHM_27T1529_8nm_ver_L, xi_um_27T1529_8nm_ver_L, '-ob');
hold on
plot(d_FWHM_27T1529_8nm_hor_L, xi_um_27T1529_8nm_hor_L, '-or');
%hold on
%plot([0 1335],[0 1335], ':k');
hold off
ylim([0 1400]); xlim([0 1.2]);
xlabel('separation / FWHM'), ylabel('coherence length \xi / um');
legend('FWHM_x=0.85mm','FWHM_x=1.05mm','FWHM_x=1.70mm','FWHM_x=2.10mm');
title('\lambda=8nm E=45uJ #Undulators=12');


%figure('rend', 'painters','pos', [510 10 500 500]);
subplot(3,3,2);
plot(d_um_29T1007_13p5nm_ver_S, xi_um_29T1007_13p5nm_ver_S, '-xb');
hold on
plot(d_um_29T1007_13p5nm_hor_S, xi_um_29T1007_13p5nm_hor_S, '-xr');
hold on
plot(d_um_29T1007_13p5nm_ver_L, xi_um_29T1007_13p5nm_ver_L, '-ob');
hold on
plot(d_um_29T1007_13p5nm_hor_L, xi_um_29T1007_13p5nm_hor_L, '-or');
hold on
plot([0 1335],[0 1335], ':k')
hold off
ylim([0 1400]);
xlabel('separation / um'), ylabel('coherence length \xi / um');
legend('FWHM_x=1.00mm','FWHM_x=1.05mm','FWHM_x=2.00mm','FWHM_x=2.10mm');
title('\lambda=13.5nm E=111uJ #Undulators=12');


%figure('rend', 'painters','pos', [510 10 500 500]);
subplot(3,3,5);
plot(d_FWHM_29T1007_13p5nm_ver_S, xi_um_29T1007_13p5nm_ver_S, '-xb');
hold on
plot(d_FWHM_29T1007_13p5nm_hor_S, xi_um_29T1007_13p5nm_hor_S, '-xr');
hold on
plot(d_FWHM_29T1007_13p5nm_ver_L, xi_um_29T1007_13p5nm_ver_L, '-ob');
hold on
plot(d_FWHM_29T1007_13p5nm_hor_L, xi_um_29T1007_13p5nm_hor_L, '-or');
hold on
%plot([0 1335],[0 1335], ':k')
%hold off
ylim([0 1400]); xlim([0 1.2]);
xlabel('separation / FWHM'), ylabel('coherence length \xi / um');
legend('FWHM_x=1.00mm','FWHM_x=1.05mm','FWHM_x=2.00mm','FWHM_x=2.10mm');
title('\lambda=13.5nm E=111uJ #Undulators=12');


%figure('rend', 'painters','pos', [1010 10 500 500]);
subplot(3,3,3);
plot(d_um_26T2300_18nm_ver_S, xi_um_26T2300_18nm_ver_S, '-xb');
hold on
plot(d_um_26T2300_18nm_hor_S, xi_um_26T2300_18nm_hor_S, '-xr');
hold on
plot(d_um_26T2300_18nm_ver_L, xi_um_26T2300_18nm_ver_L, '-ob');
hold on
plot(d_um_26T2300_18nm_hor_L, xi_um_26T2300_18nm_hor_L, '-or');
hold on
plot(d_um_26T2300_18nm_ver_L, d_um_26T2300_18nm_ver_L, ':k');
hold off
xlabel('separation / um'), ylabel('coherence length \xi / um');
legend('FWHM_x=1.20mm','FWHM_x=1.20mm','FWHM_x=2.40mm','FWHM_x=2.40mm');
title('\lambda=18.0nm E=48uJ #Undulators=7');
ylim([0 1400]);


%figure('rend', 'painters','pos', [1010 10 500 500]);
subplot(3,3,6);
plot(d_FWHM_26T2300_18nm_ver_S, xi_um_26T2300_18nm_ver_S, '-xb');
hold on
plot(d_FWHM_26T2300_18nm_hor_S, xi_um_26T2300_18nm_hor_S, '-xr');
hold on
plot(d_FWHM_26T2300_18nm_ver_L, xi_um_26T2300_18nm_ver_L, '-ob');
hold on
plot(d_FWHM_26T2300_18nm_hor_L, xi_um_26T2300_18nm_hor_L, '-or');
hold off
xlabel('separation / FWHM'), ylabel('coherence length \xi / um');
legend('FWHM_x=1.20mm','FWHM_x=1.20mm','FWHM_x=2.40mm','FWHM_x=2.40mm');
title('\lambda=18.0nm E=48uJ #Undulators=7');
ylim([0 1400]); xlim([0 1.2]);


%figure('rend', 'painters','pos', [510 10 500 500]);
subplot(3,3,7);
plot(d_FWHM_27T1529_8nm_ver_S, zeta_27T1529_8nm_ver_S, '-xb');
hold on
plot(d_FWHM_27T1529_8nm_hor_S, zeta_27T1529_8nm_hor_S, '-xr');
hold on
plot(d_FWHM_27T1529_8nm_ver_L, zeta_27T1529_8nm_ver_L, '-ob');
hold on
plot(d_FWHM_27T1529_8nm_hor_L, zeta_27T1529_8nm_hor_L, '-or');
%hold on
%plot([0 1335],[0 1335], ':k');
hold off
ylim([0 0.6]); xlim([0 1.2]);
xlabel('separation / FWHM'), ylabel('global degree of coherence \zeta');
legend('FWHM_x=1.00mm','FWHM_x=1.05mm','FWHM_x=2.00mm','FWHM_x=2.10mm');
title('\lambda=8nm E=45uJ #Undulators=12');


%figure('rend', 'painters','pos', [1010 10 500 500]);
subplot(3,3,8);
plot(d_FWHM_29T1007_13p5nm_ver_S, zeta_29T1007_13p5nm_ver_S, '-xb');
hold on
plot(d_FWHM_29T1007_13p5nm_hor_S, zeta_29T1007_13p5nm_hor_S, '-xr');
hold on
plot(d_FWHM_29T1007_13p5nm_ver_L, zeta_29T1007_13p5nm_ver_L, '-ob');
hold on
plot(d_FWHM_29T1007_13p5nm_hor_L, zeta_29T1007_13p5nm_hor_L, '-or');
%hold on
%plot(d_um_26T2300_18nm_ver_L, d_um_26T2300_18nm_ver_L, ':k');
hold off
xlabel('separation / FWHM'), ylabel('global degree of coherence \zeta');
legend('FWHM_x=1.00mm','FWHM_x=1.05mm','FWHM_x=2.00mm','FWHM_x=2.10mm');
title('\lambda=13.5nm E=111uJ #Undulators=12');
ylim([0 0.6]); xlim([0 1.2]);


%figure('rend', 'painters','pos', [1010 10 500 500]);
subplot(3,3,9);
plot(d_FWHM_26T2300_18nm_ver_S, zeta_26T2300_18nm_ver_S, '-xb');
hold on
plot(d_FWHM_26T2300_18nm_hor_S, zeta_26T2300_18nm_hor_S, '-xr');
hold on
plot(d_FWHM_26T2300_18nm_ver_L, zeta_26T2300_18nm_ver_L, '-ob');
hold on
plot(d_FWHM_26T2300_18nm_hor_L, zeta_26T2300_18nm_hor_L, '-or');
hold off
xlabel('separation / FWHM'), ylabel('global degree of coherence \zeta');
legend('FWHM_y=1.20mm','FWHM_x=1.20mm','FWHM_y=2.40mm','FWHM_x=2.40mm');
title('\lambda=18.0nm E=48uJ #Undulators=7');
ylim([0 0.6]); xlim([0 1.2]);



%% total degree of coherence \zeta is \zeta_vertical * \zeta_horizontal
%%
findmax = false;  
% look for the maximum Intensity in the image or use the
% center coordinates from the definitions above 
% (which were found with the jupyter script semiautomatic by hand)
%% 
% unit definitions:
m = 1 ;
nm = 1e-9 ;
um = 1e-6 ;
mm = 1e-3 ;
cm = 1e-2 ;
R_1 = 1/um ;

% parameters of the experiment:
wavelength = wavelength_nm * nm ;
k = 2*pi/wavelength ;
%n = 1024 ; % number of pixels of the full pixis 1024B
R = 10 * um ; % pinhole diameter
z = 5781 * mm ; % distance pinholes to detector
%d_um = 215;
d = d_um * um ; % pinhole separation

% loading the data
I_pixis = pixis_image_norm;
I_pixis = norm_function(I_pixis);  % normalize

% center of the interference pattern:
if findmax == true
    [M,idx] = max(I_pixis(:));
    [idx_row, idx_col] = ind2sub(size(I_pixis),idx);
else   
    idx_row = pixis_centery_px;
    idx_col = pixis_centerx_px;
end

% number of pixels in the rotated and cropped image of the PIXIS CCD:
n = size(pixis_image_norm);
n = n(1);

% pixel size of the detector dX_1
dX_1 = 13 * 1e-6 ;
dY_1 = dX_1 ;

% 2D grid and axes at the CCD:
[X_1,Y_1] = meshgrid(dX_1*(-n/2:n/2-1),dY_1*(-n/2:n/2-1)) ; % numerical grid
X1_axis = ((1:n)-floor(n/2)-1) * dX_1;
Y1_axis = ((1:n)-floor(n/2)-1) * dY_1;

z_0 = 1067 * mm ;
z_T = z + z_0 ;
z_eff = z * z_0 / (z_T) ;

% "pixelsize" at the pinholes:
dX_2 = wavelength*z/(n*dX_1);
dY_2 = wavelength*z/(n*dY_1);

% 2D grid and axes at the double pinholes:
[X_2,Y_2] = meshgrid(dX_2*(-n/2:n/2-1),dY_2*(-n/2:n/2-1));
X2_axis = ((1:n)-floor(n/2)-1)*dX_2;
Y2_axis = ((1:n)-floor(n/2)-1)*dY_2;

% initial psf guess as ones:

%psfi = ones(size(I)/20);

%Sigma = 0.5 * 1e-3 ; 
%F_gamma_est = GAUSS(X_1,Y_1,Sigma);

%F_gamma_est = F_gamma_rec;

%F_gamma_est= ones(size(I_pixis));

% parameters of the deconvolution algorithm
iter = 30;  % number of iteration
dampar = 1e-3;  % damping parameter
weight = ones(size(I_pixis));
weight(I_pixis<0.2e-2) = 0;  % why?

readout = [];
%
%Sigma_um = [50:50:600];
%Sigma_um = 28;
%Sigma_um_min = 27;
%Sigma_um_max = 27;
%Sigma_um_array = [Sigma_um-5:1:Sigma_um+2];
Sigma_um_array = [Sigma_um_min:1:Sigma_um_max];
Sigma_um_array = [Sigma_um];
%

if run_sigma_scan == true

    for i=1:length(Sigma_um_array)
        Sigma_um_array(i)
        Sigma = Sigma_um_array(i) * 1e-6;
        F_gamma_est = GAUSS(X_1,Y_1,Sigma); % create start estimate for F_gamma assuming to be a Gaussian
        F_gamma_est = norm_function(F_gamma_est);  % normalize it

        % blind deconvolution algorithm gives reconstructed fully coherent
        % pattern I_rec and corresponding F_gamma_rec
        [I_rec(:,:,i),F_gamma_rec(:,:,i)] = deconvblind(I_pixis,F_gamma_est,iter,dampar,weight,readout);
        I_rec(:,:,i) = norm_function(I_rec(:,:,i)); % normalize
        F_gamma_rec(:,:,i) = norm_function(F_gamma_rec(:,:,i));  % normalize

        % gamma_rec as inverse FT from F_gamma:
        gamma_rec(:,:,i) = ifourier2D(F_gamma_rec(:,:,i));

        % correlation coefficent between measurement and fully coherent
        % reconstuction
        corr_I_pixis_I_rec(i) = corr2(I_pixis,I_rec(:,:,i));


        %--- determine coherence length \xi as the sigma of the vertical lineout of abs(gamma)

        % abs(gamma_rec):
        abs_gamma(:,:,i) = norm_function(abs(gamma_rec(:,:,i)));

        % lineout at pinhole plate position
        x = Y2_axis*R_1;
        y = abs_gamma(:,round(n/2+1),i);  % vertical lineout of abs(gamma)

        % fit Gaussian:
        options = fitoptions('gauss1');
        % amplitude should be 1 and shift 0
        options.Lower = [1 0 0];
        options.Upper = [1 0 Inf];
        % do the fit:
        [f, G, O] = fit(x.',y,'gauss1')
        f_coeff = coeffvalues(f);
        % coherence length \xi is the sigma of the fitted Gaussian:
        xi_um(i) = f_coeff(3)/sqrt(2);


        %--- determine a Gaussian fit F_gamma_rec2 of F_gamma_rec (to quantify F_gamma_rec)
        x = Y1_axis*R_1;
        y = F_gamma_rec(:,round(n/2+1),i);

        options = fitoptions('gauss1');
        options.Lower = [1 0 0];
        options.Upper = [1 0 Inf];
        [f, G, O] = fit(x.',y,'gauss1',options)
        f_coeff = coeffvalues(f);
        Sigma_rec2_um(i) = f_coeff(3)/sqrt(2);

        y_hor = F_gamma_rec(round(n/2+1),:,i).'; % make a horizontal lineout of F_gamma_rec
        % it's only one or two pixel wide for the lineout ...

        Sigma_rec2 = Sigma_rec2_um(i) * 1e-6;
        F_gamma_rec2(:,:,i) = GAUSS(X_1,Y_1,Sigma_rec2); % Gaussian based on fit on horizontal lineout of F_gamma_rec

        F_gamma_rec2(:,:,i) = norm_function(F_gamma_rec2(:,:,i));


        %--- convolve reconstructed fully coherent Intensity I_rec with the found F_gamma_rec to check with the original measurement data

        I_pc_rec(:,:,i) = conv2(I_rec(:,:,i),F_gamma_rec(:,:,i),'same');
        %I_pc_rec = norm_function(I_pc_rec(round(n/2):(end-round(n/2)),round(n/2):(end-round(n/2))));
        I_pc_rec(:,:,i) = norm_function(I_pc_rec(:,:,i));

        %I_pc_rec2(:,:,i) = conv2(I_rec(:,:,i),F_gamma_rec2(:,:,i),'same');
        %I_pc_rec2(:,:,i) = norm_function(I_pc_rec2(round(n/2):(end-round(n/2)),round(n/2):(end-round(n/2))));
        % fixing????

        pixis_image_norm_hist(:,:,i) = imhist(pixis_image_norm);
        I_pc_rec_hist(:,:,i) = imhist(I_pc_rec(:,:,i));
        D(i) = pdist2(I_pc_rec_hist(:,:,i)', pixis_image_norm_hist(:,:,i)', 'chisq');

        corr_I_pixis_I_pc_rec(i) = corr2(I_pixis,I_pc_rec(:,:,i));

        %--- lineouts of partially coherent measurement and fully coherent reconstruction
        deltay = 25;

        I_pixis_profile = norm_function(mean(I_pixis(idx_row-deltay:idx_row+deltay,:)));
        I_pixis_profile_min = min(I_pixis_profile(round(n/2)-200:round(n/2)+200));
        I_rec_profile(:,:,i) = norm_function(mean(I_rec(idx_row-deltay:idx_row+deltay,:,i)));
        I_rec_profile_min(i) = min(I_rec_profile(:,round(n/2)-200:round(n/2)+200,i));
    end
end
%%
figure('rend', 'painters','pos', [10 10 500 1500]);

nrows = 6;
subplot(nrows,1,1)
plot(Sigma_um_array,corr_I_pixis_I_rec,'-xb');
xlabel('\sigma/um'), ylabel('corr_I_pixis_I_rec');

subplot(nrows,1,2)
plot(Sigma_um_array,xi_um,'-xb');
xlabel('\sigma/um'), ylabel('coherence length \xi / um');

subplot(nrows,1,3)
plot(Sigma_um_array,Sigma_rec2_um,'-xb');
xlabel('\sigma/um'), ylabel('Sigma of F(\gamma)');

subplot(nrows,1,4)
plot(Sigma_um_array,D,'-xb');
xlabel('\sigma/um'), ylabel('Distance between histograms');

subplot(nrows,1,5)
plot(Sigma_um_array,corr_I_pixis_I_pc_rec,'-xb');
xlabel('\sigma/um'), ylabel('{corr_I_pixis_I_pc_rec}');

subplot(nrows,1,6)
plot(Sigma_um_array,I_rec_profile_min,'-xb');
xlabel('\sigma/um'), ylabel('minimum of reconstructed Profile');

%% pick the Sigma_um by hand, where I_rec_profile_min becomes 0 or is minimal
%Sigma_um = 25;  % change it here, otherwise use the value defined above
i = find(Sigma_um_array==Sigma_um)
xi_um(i)

%%
% figure(2);
% imagesc(X1_axis*R_1,Y1_axis*R_1,F_gamma_est);
% axis equal; 
% title(strcat('Estimation of F(\gamma) as Gaussian with \sigma=',num2str(Sigma_um(i)),'um')); 
% xlabel('x/um'), ylabel('y/um');
% colormap(gca,jet);


%% backpropagate Intensity to double pinhole plate
% backpropagate Intensity to the pinhole plate by doing a inverse FT of the
% measurement
A_bp = ifourier2D(sqrt(I_pixis));  % amplitude
I_bp = abs(A_bp).^2;  % intensity

figure('rend', 'painters','pos', [1010 510 500 500]);
imagesc(X2_axis*R_1,Y2_axis*R_1,log10(I_bp));
colormap(gca,jet);
title('log10(I_{ph} = FT(I_{pixis})) (backpropagated intensity at pinhole plate)');
colorbar; 
axis equal;
xlabel('x/um'), ylabel('y/um');



%%
figure('rend', 'painters','pos', [1010 10 500 1500]);

subplot(3,1,1);
imagesc(X1_axis*R_1,Y1_axis*R_1,F_gamma_rec(:,:,i)); colormap(gca,jet); title(strcat('recovered F(\gamma) at CCD, \sigma=',num2str(Sigma_um_array(i)),'um',', iter=',num2str(iter),', \lambda = ',num2str(wavelength_nm),'nm', ', d=',num2str(d_um),'um'));colorbar; axis equal tight;
xlabel('x/um'), ylabel('y/um');

subplot(3,1,2);
imagesc(X2_axis*R_1,Y2_axis*R_1,abs_gamma(:,:,i)); colormap(gca,jet); title(strcat('recovered abs(\gamma) at Pinholes, xi=',num2str(xi_um(i)),'um'));colorbar; axis equal tight;
xlabel('x/um'), ylabel('y/um');


% lineout at pinhole plate position
subplot(3,1,3)
x = Y2_axis*R_1;
y = abs_gamma(:,round(n/2+1),i);  % vertical lineout of abs(gamma)
% missing fit!
plot(x,y);
xlabel('x/um'), ylabel('abs(\gamma)_{rec}');



%% histogram comparison between orginal image and reconstructed partially coherent image
figure('rend', 'painters','pos', [510 10 500 500]);

subplot(2,2,1);
imagesc(X1_axis*R_1,Y1_axis*R_1,I_pixis);
colormap(gca,jet); title(strcat('partially coherent measurement I_{pixis} at CCD', ', \lambda = ',num2str(wavelength_nm),'nm', ', d=',num2str(d_um),'um')); colorbar; axis equal;
xlabel('x/um'), ylabel('y/um');
axis equal tight;

subplot(2,2,3);
imagesc(X1_axis*R_1,Y1_axis*R_1,I_pc_rec(:,:,i));
axis equal tight; title(strcat('I_{rec} * F(\gamma)_{rec} from blind deconvolution')); 
xlabel('x/um'), ylabel('y/um');
colormap(gca,jet); colorbar;

subplot(2,2,2);
imhist(pixis_image_norm);
title(strcat('partially coherent measurement I_{pixis} at CCD', ', \lambda = ',num2str(wavelength_nm),'nm', ', d=',num2str(d_um),'um'));

subplot(2,2,4);
imhist(I_pc_rec(:,:,i));
title(strcat('I_{rec} * F(\gamma)_{rec} from blind deconvolution (D=', num2str(D(i)), ')')); 


%% overview plots

figure('rend', 'painters','pos', [1010 10 1500 1000]);

subplot(2,3,1);
imagesc(X1_axis*R_1,Y1_axis*R_1,I_pixis); colormap(gca,jet); title(strcat('partially coherent measurement I_{pixis} at CCD', ', \lambda = ',num2str(wavelength_nm),'nm', ', d=',num2str(d_um),'um')); colorbar; axis equal;
xlabel('x/um'), ylabel('y/um');
axis equal tight;

subplot(2,3,2);
imagesc(X1_axis*R_1,Y1_axis*R_1,I_rec(:,:,i)); colormap(gca,jet);
title(strcat('recovered coherent measurement I_{rec} at CCD,  \sigma=',num2str(Sigma_um_array(i)),'um',', iter=',num2str(iter),', r=',num2str(corr_I_pixis_I_rec(i))));colorbar; axis equal;
xlabel('x/um'), ylabel('y/um');
axis equal tight;

subplot(2,3,3);
imagesc(X1_axis*R_1,Y1_axis*R_1,I_pc_rec(:,:,i));
axis equal tight; title(strcat('I_{rec} * F(\gamma)_{rec} from blind deconvolution')); 
xlabel('x/um'), ylabel('y/um');
colormap(gca,jet); colorbar;

subplot(2,3,4);
imagesc(X1_axis*R_1,Y1_axis*R_1,F_gamma_rec(:,:,i)); colormap(gca,jet); title(strcat('recovered F(\gamma)_{rec} at CCD, \sigma_{est,Gauss}=',num2str(Sigma_um_array(i)),'um',', iter=',num2str(iter)));colorbar; axis equal;
xlabel('x/um'), ylabel('y/um');
axis equal tight;

% subplot(2,3,5);
% imagesc(X1_axis*R_1,Y1_axis*R_1,F_gamma_rec2(:,:,i)); title(strcat('recovered F(\gamma)_{rec,Gauss} as Gaussian with \sigma_{rec,Gauss}=',num2str(Sigma_rec2_um(i)),'um')); 
% xlabel('x/um'), ylabel('y/um');
% colormap(gca,jet); colorbar;
% axis equal tight;
% 
% subplot(2,3,6);
% imagesc(X1_axis*R_1,Y1_axis*R_1,I_pc_rec2(:,:,i));
% axis equal tight; title(strcat('I_{rec} * F(\gamma)_{rec,Gauss} as Gaussian with \sigma_{rec,Gauss}=',num2str(Sigma_rec2_um(i)),'um')); 
% xlabel('x/um'), ylabel('y/um');
% colormap(gca,jet); colorbar;


%% lineouts of partially coherent measurement and fully coherent reconstruction
figure('rend', 'painters','pos', [10 10 1500 1100]);
deltay = 25;
I_pixis_profile = norm_function(mean(I_pixis(idx_row-deltay:idx_row+deltay,:)));
min(I_pixis_profile(round(n/2)-200:round(n/2)+200))
plot(X1_axis*R_1,I_pixis_profile,'-b', 'LineWidth',3);
hold on
plot(X1_axis*R_1,I_rec_profile(:,:,i),'-r', 'LineWidth',1);
hold off
%legend('I_{pc,data}','I_{c,rec}','FontSize', 24);
legend({'partially coherent measurement','fully coherent reconstruction'});
title(strcat('\lambda = ',num2str(wavelength_nm),'nm', ', separation d=',num2str(d_um),'um, ', ' coherence length \xi=',num2str(round(xi_um(i),1)),'um'));
xlim([-6500,6500])
xlabel('detector position / um')
ylabel('Intensity / a.u.')


%% pinhole image
figure('rend', 'painters','pos', [510 510 1000 1000]);
imagesc(pinholes_image_norm); colormap(gca,jet);