
n = 15;

wpass = 0.12*pi;        % passband cutoff freq (in radians)
wstop = 0.24*pi;        % stopband start freq (in radians)
max_pass_ripple =.3;    % (delta) max allowed passband ripple in dB
                        % ideal passband gain is 0 dB

%********************************************************************
% create optimization parameters
%********************************************************************
N = 30*n;                              % freq samples (rule-of-thumb)
w = linspace(0,pi,N);
A = [ones(N,1) 2*cos(kron(w',[1:n]))]; % matrix of cosines

% passband 0 <= w <= w_pass
ind = find((0 <= w) & (w <= wpass));    % passband
Lp  = 10^(-max_pass_ripple/20)*ones(100,1);
Up  = 10^(max_pass_ripple/20)*ones(100,1);
Ap  = A(ind,:);

% transition band is not constrained (w_pass <= w <= w_stop)

% stopband (w_stop <= w)
ind = find((wstop <= w) & (w <= pi));   % stopband
As  = A(ind,:);
 
%********************************************************************
% optimization
%********************************************************************
% formulate and solve the linear-phase lowpass filter design
cvx_begin
  variable h1(n+1,1)
 hhh=[h1.' zeros(1,N-length(h1))]*wmat(N);
  minimize( max( abs( hhh(150:300))))
  subject to
    % passband bounds
    Lp <= abs(hhh(1:100)).';
    abs(hhh(1:100))<= Up;
cvx_end

% check if problem was successfully solved
disp(['Problem is ' cvx_status])
if ~strfind(cvx_status,'Solved')
  return
else
  fprintf(1,'The minimum attenuation in the stopband is %3.2f dB.\n\n',...
          20*log10(cvx_optval));
  % construct the full impulse response
  h = [flipud(h1(2:end)); h1];
end

%********************************************************************
% plots
%********************************************************************
figure(1)
% FIR impulse response
plot([0:2*n],h','o',[0:2*n],h','b:')
xlabel('t'), ylabel('h(t)')

figure(2)
% frequency response
H = exp(-j*kron(w',[0:2*n]))*h;
% magnitude
subplot(2,1,1)
plot(w,20*log10(abs(H)),...
     [0 wpass],[max_pass_ripple max_pass_ripple],'r--',...
     [0 wpass],[-max_pass_ripple -max_pass_ripple],'r--');
axis([0,pi,-100,10])
xlabel('w'), ylabel('mag H(w) in dB')
% phase
subplot(2,1,2)
plot(w,angle(H))
axis([0,pi,-pi,pi])
xlabel('w'), ylabel('phase H(w)')
