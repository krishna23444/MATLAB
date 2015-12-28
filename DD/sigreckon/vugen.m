clc
clear all


for k=23
    
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

            xy1(:,n1)=[a1(n1,1);a1(n1,2)];
    figure(2)
    plot(double(a1(n1,1)),double(a1(n1,2)),'ro')
hold on

end
% t1 = 1:n1;
% ts1 = 1: 0.5: n1;
% xys1 = spline(t1,xy1,ts1);
% figure(2)
% plot(xys1(1,:),xys1(2,:),'b-')

% for n2=1:Na2(1)
%     xy2(:,n2)=[a2(n2,1);a2(n2,2)];
%     figure(1)
%     plot(double(a2(n2,1)),double(a2(n2,2)),'ro')
% hold on
% 
% end
% t2 = 1:n2;
% ts2 = 1: 0.5: n2;
% xys2 = spline(t2,xy2,ts2);
% figure(1)
% plot(xys2(1,:),xys2(2,:),'b-')

pause(2)
    end
    
end
 

       
    

        
        
        