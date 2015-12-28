function version=checkmarkversion(dum)
version='1.2';

% VERSION HISTORY

% version 1.1 November 7, 2001 (internal version) new attacks: thresh, dither, downup sample. New applications: video frame, medical imaging, logos

% version 1.0.5 July 6, 2001 at 20:44 better support for the table generation.  Now supports generation of multiple technologies with missing applications.  Important
% changes to Watson metric.  The parameters have been modified to yield more accurate results.  The changes are somewhat empirical, but seem to make a huge difference.
% version 1.0.4 June 21, 2001 at 15:45 :bug fixed in midpoint and trimmed mean,  the previous bug fix introduced a bug, now works
% version 1.0.3 Date:June 21, 2001  Time:14:18  bug fix in the watson metric the luminance parameter coo was set too high.  Changed to 10 from 128.

% version 1.0.2  Date:June 20, 2001  Time:09:28 bug fix in trimmed mean filter and midpoint filter, windowsize was double the window size expected.  Also getparams.m changed
% to getParams.m.  This was a problem on Unix
% 1.0 original version

