function y=fid(r,A,B,om)

W=kaiser(2*r+1,A);

n=1:r;
Q=2*sum(((iod(B).*sqrt(1-(n./r).^2).*besseli(A,0)-iod(A).*besseli(B,0))./(besseli(A,0)).^2).*h(n).*sin(n.*om))

P=2*sum(W(n).*h(n).*sin(n.*om));