function S=rre1eirpdb(EIRP,R,Gr,f)
% RRE1EIRPDB  Power at receiver using decibal I/O and radar range equation
% S=rre1eirpdb(EIRP,R,Gr,f)
% TODO: Help
S=EIRP-11-2*R+2*g2db(3e8/f)+Gr-11;