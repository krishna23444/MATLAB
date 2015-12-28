addpath F:\XXX; % adds the directory C:\XXX to the list of directories which Matlab "sees" (referred to as paths)
mlpath='F:\XXX' % The directory where mathlink.h is
mllib='F:\XXX\ml32i1m.lib' %The library ml32i1m.lib

%make command
command=sprintf('mex -D__STDC__ -I%s %s %s', mlpath, 'math.c', mllib);
%compile
eval(command)  