gammaavg=10;
gamma=0:.1:60;
M=[1 2 4 8 10];
for i=1:5
    pdf(i,:)=(M(i)/gammaavg)*((1-exp(-gamma/gammaavg)).^(M(i)-1)).*(exp(-gamma/gammaavg));
end
subplot(1,2,1);
for i =1:5
    plot(gamma,pdf(i,:))
    hold on
end
xlabel('Gamma');
ylabel('PDF(gamma)');
%% cdf
for i=1:5
    cdf(i,:)=(1-exp(-gamma/gammaavg)).^(M(i));
end
subplot(1,2,2);
for i =1:5
    plot(gamma,cdf(i,:))
    hold on
 end
xlabel('Gamma');
ylabel('CDF(Outage Probability)');