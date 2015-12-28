
%%%%%%%%%%%%%% Enriching_filter_design_27.m  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A commented version of the Matlab script file in the shaded box on
% page 97 of
% T. N. Davidson,
% "Enriching the art of FIR filter design via convex optimization",
% IEEE Signal Processing Magazine,
% 27(3):89-101, May 2010.


%%%%%%%%%%%%%%%%% Legal Statements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copyright (C) January 2010.
% Timothy N. Davidson,
% Dept. Elec. & Comp. Engineering,
% McMaster University,
% 1280 Main Street West,
% Hamilton, Ontario, L8S 4K1, Canada.
% davidson@mcmaster.ca

% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% A copy of the GNU General Public License is available on the web at:
% http://www.gnu.org/copyleft/gpl.html; or by writing to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% The m-file begins... %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Data
  L = 48;
  M = 8;
  K = 6;
  rel_sb_level_dB = -33; 
  alpha = 10^(-3);
 
% Frequency sampling parameters
  sf = 15;
  eps_sf = 1e-6;
 
% Calculate bounds
  xi_3_sqr = 10^(0.1)*K;
  xi_2_sqr = xi_3_sqr*10^(rel_sb_level_dB/10);
  xi_4 = alpha*K/M;
           
% Components of sampled mask constraints
  omega_s = pi/K;
  k_vecT = 1:(L-1);
  
  Ns_pt = ceil(L*sf*omega_s/pi);
  Ns_s = ceil(L*sf*(1-omega_s/pi));
  
  omega_ptb = linspace(0,omega_s,Ns_pt+1)';
  omega_ptb = omega_ptb(1:end-1);
  omega_sb = linspace(omega_s,pi,Ns_s)';
  
  VtildeT_ptb = [ones(Ns_pt,1), 2*cos(omega_ptb*k_vecT)];
  VtildeT_sb = [ones(Ns_s,1), 2*cos(omega_sb*k_vecT)];
           
% Components of self-orthog. constraint
  N_isi = floor((L-1)/M); 
  k_isi_vector = M*(1:N_isi)';
  S = eye(L); 
  S = S(k_isi_vector+1,:);
 
% Objective
  gT=[1-1/K, -2*sin(pi*k_vecT/K)./(pi*k_vecT)];
  
% Construct and solve the problem
  cvx_begin
 
   cvx_solver sedumi
   cvx_precision high
  
   variable rtilde_h(L);
   variable X(L,L) symmetric;
  
   minimize (gT*rtilde_h)
   subject to
     VtildeT_sb*rtilde_h  <= xi_2_sqr - eps_sf;
     VtildeT_ptb*rtilde_h <= xi_3_sqr - eps_sf;
     norm(S*rtilde_h) <= xi_4/sqrt(2);
     [1,zeros(1,L-1)]*rtilde_h == K/M;
     X == semidefinite(L);
     trace(X) == rtilde_h(1);
     for n=1:L-1,
       sum(diag(X,n)) == rtilde_h(n+1);
     end;
   
  cvx_end
