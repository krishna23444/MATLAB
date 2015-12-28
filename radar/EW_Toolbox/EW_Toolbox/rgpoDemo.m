function rgpoDemo()
% RGPODEMO  Visual demonstration of range gate pull out
% 
%   AIM: To demonstrate RGPO
% 
% TODO: Help

%% Figure
figure (1)
clf

subplot(4,1,1)
axis([2 10 0 8])
rectangle('Position',[4.75,-2,.5,4],'Curvature',[1,1],'FaceColor','g')
rectangle('Position',[4,0,1,6])
rectangle('Position',[5,0,1,6],'EdgeColor','b')
text(2.5,3,'Early gate \rightarrow','FontSize',14)
text(6,3,'\leftarrow Late gate','FontSize',14)
text(3.4,1,'Target \rightarrow','FontSize',14)
text(8.6,3,'Gate Ratio','FontSize',14)
set(gca,'XTickLabel',' ')
set(gca,'YTickLabel',' ')
hold on
bar(9.3,2,.25,'FaceColor','k')
bar(9.7,2,.25,'FaceColor','b')


subplot(4,1,2)
axis([2 10 0 8])
rectangle('Position',[4.75,-6,.5,13],'Curvature',[1,1],'FaceColor','r')
rectangle('Position',[4.75,-2,.5,4],'Curvature',[1,1],'FaceColor','g')
rectangle('Position',[4,0,1,6])
rectangle('Position',[5,0,1,6],'EdgeColor','b')
% text(3,3,'Slow gate \rightarrow')
% text(6,3,'\leftarrow Fast gate')
% text(4,1,'Target \rightarrow')
text(3,5,'False Target \rightarrow','FontSize',14)
set(gca,'XTickLabel',' ')
set(gca,'YTickLabel',' ')
hold on
bar(9.3,5,.25,'FaceColor','k')
bar(9.7,5,.25,'FaceColor','b')

subplot(4,1,3)
axis([2 10 0 8])
rectangle('Position',[5.5,-6,.5,13],'Curvature',[1,1],'FaceColor','r')
rectangle('Position',[4.75,-2,.5,4],'Curvature',[1,1],'FaceColor','g')
rectangle('Position',[4,0,1,6])
rectangle('Position',[5,0,1,6],'EdgeColor','b')
% text(3,3,'Slow gate \rightarrow')
% text(6,3,'\leftarrow Fast gate')
set(gca,'XTickLabel',' ')
set(gca,'YTickLabel',' ')
hold on
bar(9.3,2,.25,'FaceColor','k')
bar(9.7,7,.25,'FaceColor','b')

subplot(4,1,4)
axis([2 10 0 8])
rectangle('Position',[6.25,-6,.5,13],'Curvature',[1,1],'FaceColor','r')
rectangle('Position',[4.75,-2,.5,4],'Curvature',[1,1],'FaceColor','g')
rectangle('Position',[5.5,0,1,6])
rectangle('Position',[6.5,0,1,6],'EdgeColor','b')
% text(4.5,3,'Slow gate \rightarrow')
% text(7.5,3,'\leftarrow Fast gate')
set(gca,'XTickLabel',' ')
set(gca,'YTickLabel',' ')
xlabel('Time (Range) $\longrightarrow$','Interpreter','Latex')
hold on
bar(9.3,5,.25,'FaceColor','k')
bar(9.7,5,.25,'FaceColor','b')

print -dpdf rgpo.pdf