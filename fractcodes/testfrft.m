% test for Disfrft, cdpei, frft, frft2

x=0.0:0.02:2*pi; y =cos(x);
clear p_saved hn_saved E_saved
for a=0:0.05:4
    fy=Disfrft(y,a);
    fys=cdpei(y,a);
    fyss=frft(y,a);
    fysss=frft2(y,a);
    % blue,green,red,cyan
    figure(1)
    subplot(411);plot(x,real([fyss,fysss]));
    subplot(412);plot(x,real([fy,fys]));
    title(['a = ',num2str(a)]);
    subplot(413);plot(x,imag([fy,fys,fyss,fysss]));
    subplot(414);plot(x,abs([fy,fys,fyss,fysss]));
    
    pause(1.2);
end
