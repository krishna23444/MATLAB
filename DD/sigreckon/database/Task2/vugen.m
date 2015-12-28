clc
clear all
close all

for k=8
    
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
        
        
        kl=1;
        dif=1;
        nk=1;
        ll=1;
       while nk<=Na1(1)-1
            
            if dif<800
            cv(:,ll,kl)=[a1(nk,1);a1(nk,2)];
            dif=sqrt(abs((a1(nk+1,1)-a1(nk,1)).^2-(a1(nk+1,2)-a1(nk,2)).^2));
            ll=ll+1;
            else
            kl=kl+1;
            ll=1;
            dif=1;
            end
            nk=nk+1;
       end
      
        for oo=1:14
            bb=find(cv(1,:,oo)==0)-1
            if bb(1)==1;
               plot(cv(:,1,oo),'-b')
            else
            t=1:bb(1)
            ts=1:.5:bb(1);
            xys=spline(t,cv(:,1:bb(1),oo),ts);
            
            plot(xys(1,:),xys(2,:),'b-')
            
            end
            clear bb xys t ts 
            hold on
        end
            
        
%         for n1=2:Na1(1)
%             
%             dif1=a1(n1,1)-a1(n1-1,1);
%             dif2=a1(n1,2)-a1(n1-1,2);
%             dif=sqrt(abs(dif1.^2-dif2.^2))
%             
%             xy1(:,n1)=[a1(n1,1);a1(n1,2)];
%             if dif<300
%             t1 = 1;
%             ts1 = 1: 0.5: 2;
%             xys1 = spline(t1,xy1(:,n1-1:n1),ts1);
%             figure(2)
%             plot(xys1(1,:),xys1(2,:),'b-')
%             end
%     figure(2)
%     axis([min(double(a1(:,1)))-450 max(double(a1(:,1)))+450 min(double(a1(:,2)))-450 max(double(a1(:,2)))+450])
%     plot(double(a1(n1,1)),double(a1(n1,2)),'ro')
%     hold on
%             
%         end
        
    end

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

% pause(2)
end
