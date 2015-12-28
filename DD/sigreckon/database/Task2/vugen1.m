clc
clear all
close all

for k=23:23
    
    for l=10
        close all
        st='UqkSbl.txt';
        st1='UqkSbl.txt';
        
        if k<=9
        st(2)=[];
        st(2)=int2str(k);
        st1(2)=[];
        st1(2)=int2str(k);
          
        if l<=9
        st(4)=[];
        st(4)=int2str(l);
        else
        
        st(4:5)=int2str(l);
        end
        
        st1(4:5)=int2str(l+20);
        
        
        else
        st(2:3)=int2str(k);
        st1(2:3)=int2str(k);
        
        if l<=9
        st(5)=[];
        st(5)=int2str(l);
        else
        
        st(5:6)=int2str(l);
        end
        
        st1(5:6)=int2str(l+20);
        end
        
        
      
        x=dlmread(st);
        y=dlmread(st1);
        x(1,:)=[];
        y(1,:)=[];
        a2=y(:,1:2);
        Na2=size(a2);
        a1=x(:,1:2);
        Na1=size(a1);
        
       
        
        for n1=1:Na1(1)
          
          
    figure(2)
    axis([min(double(a1(:,1)))-450 max(double(a1(:,1)))+450 min(double(a1(:,2)))-450 max(double(a1(:,2)))+450])
    plot(double(a1(n1,1)),double(a1(n1,2)),'ro')
    hold on
            
        end
        
    

% for n2=1:Na2(1)
%     
%     figure(1)
%     plot(double(a2(n2,1)),double(a2(n2,2)),'ro')
% hold on
% 
% end


pause(1)
    end
end
