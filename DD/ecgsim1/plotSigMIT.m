function plotSigMIT(sigfile)
%Evaluation of ECG Segmentation application developed under Builder C++ 6.0
%sigfile has been created using Matlab libraries in Builder 

%clear all;
close all;
clc; more off;
warning off;

eval(['load ' sigfile]);



    %Display structure
    SigMIT
    
    %return;
    SigMIT.Samples=SigMIT.Samples(1:5000);    
    SigMIT.BeatPos=SigMIT.BeatPos(1:50);
    SigMIT.Anotation=SigMIT.Anotation(1:25);
    
    sig=figure;hold on;title('ECG signals');grid on;

    color={'b','g','r','c','m','y','k'};
    beat=zeros(1,length(SigMIT));

    %Plot ECG signals
    plot(SigMIT.Samples,color{round(unifrnd(1,7))});hold on;

    %Display beat position
    tl=max(SigMIT.Samples);	%top limit
    bl=min(SigMIT.Samples);	%bottom limit
    
    for (j=2:2:length(SigMIT.BeatPos))
        plot([SigMIT.BeatPos(j) SigMIT.BeatPos(j)],[bl tl],'b','LineWidth',2); %start of beat
    end
        
    %Display Anotations
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    n_Anot=length(SigMIT.Anotation);k=1;
	for (j=1:n_Anot)
		%PLOT
      text(SigMIT.QRS(j),tl-10,SigMIT.Anotation{j});
      plot([SigMIT.QRS(j) SigMIT.QRS(j)],[bl tl],'r-','LineWidth',2); %start of beat
   end
   

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Prepare figures
    beat=figure;hold on;title('ECG Beats of Signal');grid on;    
 
   
    %Plot extracted beats and processed beats
    for (j=1:length(SigMIT.Beats))
        plot(SigMIT.Beats{j},color{round(unifrnd(1,7))});        
    end
 
       
	%Enable zoom  
  	figure(beat);zoom on;
	figure(sig);zoom on;   


