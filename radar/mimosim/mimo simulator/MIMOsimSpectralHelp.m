function [t,y] = MIMOsimSpectral(q,nBS,nMS,kappa,mu,gamma,alpha,beta,fmax,BS_spacing,MS_spacing,Delta,NofR,dt,Tmax,Plots)

%   MIMOsimSpectral
%
%
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %  A Simple Example to Run  %
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   As an example, run     [t,y]=MIMOsimSpectral(100,2,2,0,0,0,90,90,5,1,0.5,2,90,0.01,5,1); 
%   and when prompted with [BS1 MS1 BS2 MS2 tau_max]:, enter [1 1 1 1 3].
%   
%   This examples corresponds to a 2x2 system with parallel linear arrays, where the mobile moves aways from the base station, 
%   with a constant speed such that the Maximum Doppler frequency is 5 Hz. The element spacings at the base station and mobile 
%   are one lambda and 0.5 lambda, respectively. The maximum angle spread at the base station is 4 degrees, whereas isotropic 
%   scattering is assumed around the mobile. The length of the simulated MIMO channel is 5 seconds, and any two adjacent samples 
%   are spaced by 0.01 seconds. For ensemble averaging, 90 realizations of the MIMO channel are generated.
%
%   Upon entering [1 1 1 1 3], different statistical characteristics of the simulated h11(t) will be displayed. See the following 
%   general description for further details.
% 
% 
%
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %  General Description of the Program  %
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Using the spectral representation method and the MIMO cross-spectrum given in [1], this program generates NofR 
%   realizations of a zero-mean stationary vector of nBS*nMS correlated complex Gaussian processes in the time interval 
%   (0,Tmax), which corresponds to NofR realizations of nBS*nMS correlated narrowband mobile Rayleigh fading channels.
%   
%   The MIMO space-time correlation model is given by eq. (12) of [2], in which both the BS (base station) and MS 
%   (mobile station) are equipped with uniform linear arrays. Only the MS is surrounded by local scatterers, distributed
%   on a circle.  
%
%   When the input parameter Plots is set to 1, the program allows the user to plot the theoretical, eq. (12) of [2], 
%   and simulated cross-correlations between any two subchannels, to verify the accuracy of the simulation. For example, 
%   to look at the cross-correlation between h23(t) and h41(t), i.e., E[h23(t) h41*(t+tau)], for -0.5<tau<0.5, where * here 
%   is the complex conjugate, we need to enter [3 2 1 4 0.5]. 
%
%   With Plots=1, the program also makes plots of the theoretical and simulated histograms and level crossing rate curves 
%   of the real part, the imaginary part, and the envelope of h23(t), the first subchannel specified by the above input 
%   vector example [3 2 1 4 0.5]. As a reminder, following the notation of [2] , h23(t) corresponds to the subchannel 
%   connecting the 3rd BS antenna to the 2nd MS antenna. The plots are in both the linear and dB scales.
%
%   Definitions of input parameters:     
%
%   q = Number of subintervals in the frequency domain (a typical good value is 100, but needs to be increased for a higher 
%   simulation accuracy, if necessary).
%   nBS = Number of BS antenna elements. 
%   nMS = Number of MS antenna elements.
%   kappa = Concentration parameter of the von Mises distribution for the angle of arrival at the MS (inversely 
%   related to the angle spread at the MS).
%   mu = Mean angle of arrival at the MS, in degrees.
%   gamma = Direction of the MS motion, in degrees.
%   alpha,beta = Orientations of the BS and MS antenna arrays, respectively, in degrees.
%   fmax = Maximum Doppler frequency in Hz.
%   BS_spacing = The distance between any two adjacent BS antenna elements / lambda, where lambda is the wavelength.
%	MS_spacing = The distance between any two adjacent MS antenna elements / lambda, where lambda is the wavelength.  
%   Delta = 2*Delta is the maximum angle spread at the BS, in degrees.
%   NofR = Number of realizations of the nBSxnMS matrix channel (needed for ensemble averaging).
%   dt = Temporal spacing between any two adjacent generated signal samples (time resolution).
%   Tmax = Duration of the simulated signals in seconds.
%   Plots = If set to 0, only [t,y] will be generated. When set to 1, the program first generates [t,y], then prompts 
%   the user to compare the simulated and theoretical histograms, level crossing rate curves, and correlations of the 
%   subchannels of interest.
%
%   Definitions of the output vector and matrix:
%
%	t = A vector with N=floor(Tmax/dt) nonnegative dt-spaced real elements, containing the time instants (in seconds) 
%   at which the processes are generated.
%	y = The (nBS*nMS*NofR)xN matrix of samples of nBS*nMS complex processes, cross-correlated according to the 
%   spatio-temporal correlation model of [2]. As an example, when nBS=nMS=2, the channel matrix at time t is:
%
%        | h11(t)  h12(t) |
%   H(t)=|                |.
%        | h21(t)  h22(t) |
%
%   With NofR=2 and N=3, the output y has the following structure:
%
%     |  h11(t1)  h11(t2)  h11(t3) |
%     |  h21(t1)  h21(t2)  h21(t3) |
%     |  h12(t1)  h12(t2)  h12(t3) |
%     |  h22(t1)  h22(t2)  h22(t3) |
%   y=|                            |,
%     |  h11(t1)  h11(t2)  h11(t3) |
%     |  h21(t1)  h21(t2)  h21(t3) |
%     |  h12(t1)  h12(t2)  h12(t3) |
%     |  h22(t1)  h22(t2)  h22(t3) |
%
%   where of course the lower 4x3 matrix is another realization of the upper 4x3 matrix, so, different from it. 
%
%   NOTE 1: If some simulation results do not match the theory, observed when PlotCorr=1, then at least one of the 
%   parameters q, NofR, and Tmax should be increased. 
%
%   NOTE 2: The simulated MIMO channel is applicable to both downlink and uplink. 
%
%   References
%   [1] K. Acolatse and A. Abdi, "Efficient simulation of space-time correlated MIMO mobile fading channels," 
%       in Proc. IEEE Vehic. Technol. Conf., Orlando, FL, 2003.
%   [2] A. Abdi and M. Kaveh, "A space-time correlation model for multielement antenna systems in mobile fading 
%       channels," IEEE J. Select. Areas Commun., vol. 20, pp. 550-560, 2002.     
%   
%   Copyright 2003, Kodzovi Acolatse
%   Nov. 2003
%   ver. 2.0