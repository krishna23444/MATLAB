% Copyright (c) 2001, Shelby Pereira, University of Geneva
% 
%  Permission to use, copy, modify, and distribute this software and its
%  documentation for any non-commercial purpose and without fee is hereby
%  granted (GPL), provided that the above copyright notice appear in all
%  copies and that both that copyright notice and this permission notice
% appear in supporting documentation. This software is provided "as is" 
% without express or implied warranty. The authors shall not be held
% liable in any event for incidental or consequential damages in
% connection with, or arising out of, the furnishing, performance, or
% use of this program.
% 
% If you use the Checkmark software package for your research, please cite:
%
% Shelby Pereira, Sviatoslav Voloshynovskiy, Maribel Madueño, Stéphane Marchand-Maillet
% and Thierry Pun, Second generation benchmarking and application oriented evaluation,
% In Information Hiding Workshop, Pittsburgh, PA, USA, April 2001
%
%  http://cui.unige.ch/~vision/Publications/watermarking_publications.html
%
%  
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
% no parameters
function imout =CM_templateremove(P,imin)
watermark=imin-wiener2(imin,[3 3]);
imin=imin-watermark;
ampl=abs(fft2(watermark));
L=11;
sz2=floor(L/2);
midi=floor(sz2)+1;midj=floor(sz2)+1;
% Compute magnitude and phase of stego image
spectr_stego=fft2(imin);
M_spectr_stego=(abs(spectr_stego));
phase_spectr_stego=angle(spectr_stego);
[m,n]=size(ampl);
res=zeros(m,n);
%max_wind=sum(sum(ones(L,L)));
%order filtering to get max in window
%peaks_max=ordfilt2(ampl,max_wind,ones(L)); 
peaks_mask=zeros(m,n);
killsz=80;  % the size of the central region to preserve
midptr=round(m/2);midptc=round(n/2);   count=0;                               
for i=midi+1:m-midi
  for j=midj+1:n-midj
    % it is a local peak so replace it 
	% avoid the middle of the spectrum to avoid artifacts
    if(( abs(j-midptc)>killsz) |( abs(i-midptr)>killsz))
      locblock=ampl(i-midi:i+midi,j-midj:j+midj);
      tmp1=max(max(locblock));
      if tmp1-0.0001<=(ampl(i,j))
	count=count+1;
	val=mean(mean(M_spectr_stego(i-midi:i+midi,j-midj:j+midj)));
	M_spectr_stego(i,j)=val;
      end
    end
  end
end
% Invert to coordinate domain
spectr_stego=M_spectr_stego.*exp(phase_spectr_stego*sqrt(-1));
res=real(ifft2(spectr_stego));
%res=ccrop(imrotate(res,1,'bilinear','crop'),0.95,2);
%res=imrotate(res,1,'bilinear','crop');
res(find(res<0)) = 0;res(find(res>255)) = 255;
imout=res;
return;

