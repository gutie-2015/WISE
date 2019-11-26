clear all, clc
clf(figure(1),'reset')
%%
addpath('F:\github\wearable-jacket\matlab\IEEE_sensors\');
delete(instrfind({'Port'},{'COM15'}))
ser = serial('COM15','BaudRate',115200);
ser.ReadAsyncMode = 'continuous';
fopen(ser);k=[];
pause(2);
sts = 'F:\github\wearable-jacket\matlab\IEEE_sensors\data_matched\';
cd(sts);
ttotal = 1*60;
prompt1 = 'Please enter the sensor ID attached on the moving arm respond A,B,C,D: ';
WISESENSORID = input(prompt1,'s');
% WISESENSORID = 'A';
if ~exist(num2str(WISESENSORID),'dir')
mkdir(WISESENSORID);
end
cd(strcat(sts,WISESENSORID,'\'));

prompt2 = 'Please enter the AXIS evaluated during the experiment (X,Y,Z): ';
AX = input(prompt2,'s');
if ~exist(num2str(AX),'dir')
mkdir(AX);
end

cd(strcat(sts,WISESENSORID,'\',AX,'\'));
clearvars sts;


prompt = 'Please enter the angle in degrees used for the experiment (0-180): ';
ANGLE = input(prompt,'s');

%%

gam = 30*pi/180;
rp = ((randperm(9,4)*0.1)+(randperm(9,4)*0.01))*pi/180;
gaq = size(rp);
gaq = gam+rp;
q1 = [1,0,0,0];q2 = [1,0,0,0];q3 = [1,0,0,0];q4 = [1,0,0,0];q5 = [1,0,0,0];
qI = [0,1,0,0];qJ = [0,0,1,0];qK = [0,0,0,1];qR = [1,0,0,0];
I1 = [1 0 0]; I2 = [1 0 0]; I3 = [1 0 0];I4 = [1 0 0]; I5 = [1 0 0];
J1 = [0 1 0]; J2 = [0 1 0]; J3 = [0 1 0];J4 = [0 1 0]; J5 = [0 1 0];
K1 = [0 0 1]; K2 = [0 0 1]; K3 = [0 0 1];K4 = [0 0 1]; K5 = [0 0 1];
sp = 3;lw = 2;fs = 12;
theta1 = 0;theta2 = 0;theta3 = 0;theta4 = 0;
th = -pi:10*pi/180:pi;
R = 5;  %or whatever radius you want
Cx = R*cos(th);
Cy = R*sin(th);


q1 = [cos(-pi/4),sin(-pi/4),0,0];

q2 = [cos(gaq(1)/2),0,0,sin(gaq(1)/2)];
q3 = [cos(gaq(2)/2),0,0,sin(gaq(2)/2)];
q4 = [cos(gaq(3)/2),0,0,sin(gaq(3)/2)];
q5 = [cos(gaq(4)/2),0,0,sin(gaq(4)/2)];
q1 = [cos(-pi/4),sin(-pi/4),0,0];
[~,I1(1),I1(2),I1(3)] = parts(quaternion(quatmultiply(q1,quatmultiply(qI,quatconj(q1)))));
[~,J1(1),J1(2),J1(3)] = parts(quaternion(quatmultiply(q1,quatmultiply(qJ,quatconj(q1)))));
[~,K1(1),K1(2),K1(3)] = parts(quaternion(quatmultiply(q1,quatmultiply(qK,quatconj(q1)))));

[~,I2(1),I2(2),I2(3)] = parts(quaternion(quatmultiply(q2,quatmultiply(qI,quatconj(q2)))));
[~,J2(1),J2(2),J2(3)] = parts(quaternion(quatmultiply(q2,quatmultiply(qJ,quatconj(q2)))));
[~,K2(1),K2(2),K2(3)] = parts(quaternion(quatmultiply(q2,quatmultiply(qK,quatconj(q2)))));

[~,I3(1),I3(2),I3(3)] = parts(quaternion(quatmultiply(q3,quatmultiply(qI,quatconj(q3)))));
[~,J3(1),J3(2),J3(3)] = parts(quaternion(quatmultiply(q3,quatmultiply(qJ,quatconj(q3)))));
[~,K3(1),K3(2),K3(3)] = parts(quaternion(quatmultiply(q3,quatmultiply(qK,quatconj(q3)))));

[~,I4(1),I4(2),I4(3)] = parts(quaternion(quatmultiply(q4,quatmultiply(qI,quatconj(q4)))));
[~,J4(1),J4(2),J4(3)] = parts(quaternion(quatmultiply(q4,quatmultiply(qJ,quatconj(q4)))));
[~,K4(1),K4(2),K4(3)] = parts(quaternion(quatmultiply(q4,quatmultiply(qK,quatconj(q4)))));

[~,I5(1),I5(2),I5(3)] = parts(quaternion(quatmultiply(q5,quatmultiply(qI,quatconj(q5)))));
[~,J5(1),J5(2),J5(3)] = parts(quaternion(quatmultiply(q5,quatmultiply(qJ,quatconj(q5)))));
[~,K5(1),K5(2),K5(3)] = parts(quaternion(quatmultiply(q5,quatmultiply(qK,quatconj(q5)))));
% sz2 = screensize(2);
figure(1)
set(figure (1),'keypress','k=get(gcf,''currentchar'');' );
hold on

subplot(2,1,1)
hold on
axis equal
% axis off
axis([-10 4 -1.5 1.5 -1.5 1.5]);
view([11,29]);

E1 = plot3([-3*sp,I1(1)-3*sp],[0,I1(2)],[0,I1(3)],'r','LineWidth',lw);  
E2 = plot3([-3*sp,J1(1)-3*sp],[0,J1(2)],[0,J1(3)],'g','LineWidth',lw);
E3 = plot3([-3*sp,K1(1)-3*sp],[0,K1(2)],[0,K1(3)],'b','LineWidth',lw);
Et1 = text(-0.5-3*sp,0,-0.1,'E','FontSize',fs);
Et2 = text(I1(1)-3*sp,I1(2),I1(3),'X','FontSize',fs);
Et3 = text(J1(1)-3*sp,J1(2),J1(3),'Y','FontSize',fs);
Et4 = text(K1(1)-3*sp,K1(2),K1(3),'Z','FontSize',fs);

A1 = plot3([-2*sp,-2*sp+I2(1)],[0,I2(2)],[0,I2(3)],'r','LineWidth',lw);
A2 = plot3([-2*sp,-2*sp+J2(1)],[0,J2(2)],[0,J2(3)],'g','LineWidth',lw);
A3 = plot3([-2*sp,-2*sp+K2(1)],[0,K2(2)],[0,K2(3)],'b','LineWidth',lw);
At1 = text(-0.5-2*sp,0,-0.1,'A','FontSize',fs);
At2 = text(-2*sp+I2(1),I2(2),I2(3),'X','FontSize',fs);
At3 = text(-2*sp+J2(1),J2(2),J2(3),'Y','FontSize',fs);
At4 = text(-2*sp+K2(1),K2(2),K2(3),'Z','FontSize',fs);

B1 = plot3([-1*sp,-1*sp+I3(1)],[0,I3(2)],[0,I3(3)],'r','LineWidth',lw);
B2 = plot3([-1*sp,-1*sp+J3(1)],[0,J3(2)],[0,J3(3)],'g','LineWidth',lw);
B3 = plot3([-1*sp,-1*sp+K3(1)],[0,K3(2)],[0,K3(3)],'b','LineWidth',lw);
Bt1 = text(-0.5-1*sp,0,-0.1,'B','FontSize',fs);
Bt2 = text(-1*sp+I3(1),I2(2),I2(3),'X','FontSize',fs);
Bt3 = text(-1*sp+J3(1),J2(2),J2(3),'Y','FontSize',fs);
Bt4 = text(-1*sp+K3(1),K2(2),K2(3),'Z','FontSize',fs);

C1 = plot3([0,I4(1)],[0,I4(2)],[0,I4(3)],'r','LineWidth',lw);  
C2 = plot3([0,J4(1)],[0,J4(2)],[0,J4(3)],'g','LineWidth',lw);
C3 = plot3([0,K4(1)],[0,K4(2)],[0,K4(3)],'b','LineWidth',lw);
Ct1 = text(-0.50,0,-0.1,'C','FontSize',fs);
Ct2 = text(I4(1),I4(2),I4(3),'X','FontSize',fs);
Ct3 = text(J4(1),J4(2),J4(3),'Y','FontSize',fs);
Ct4 = text(K4(1),K4(2),K4(3),'Z','FontSize',fs);

D1 = plot3([sp,sp+I5(1)],[0,I5(2)],[0,I5(3)],'r','LineWidth',lw);  
D2 = plot3([sp,sp+J5(1)],[0,J5(2)],[0,J5(3)],'g','LineWidth',lw);
D3 = plot3([sp,sp+K5(1)],[0,K5(2)],[0,K5(3)],'b','LineWidth',lw);
Dt1 = text(sp-0.50,0,-0.1,'D','FontSize',fs);
Dt2 = text(sp+I5(1),I5(2),I5(3),'X','FontSize',fs);
Dt3 = text(sp+J5(1),J5(2),J5(3),'Y','FontSize',fs);
Dt4 = text(sp+K5(1),K5(2),K5(3),'Z','FontSize',fs);
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'ZTick',[]);
set(gca,'Yticklabel',[]); 
set(gca,'Xticklabel',[]);
set(gca,'Zticklabel',[]); 
hold off

SubP2 = subplot(2,1,2);
hold on

% grid on
axis equal
% axis off
axis([-8 8 -8 8])
plot(Cx,Cy,'k.'); 
plot(0.25*Cx,0.25*Cy,'k.'); 
plot(0.5*Cx,0.5*Cy,'k.'); 
plot(0.75*Cx,0.75*Cy,'k.'); 
plot([-5.5,5.5],[0,0],'k--');
plot([0,0],[-5.5,5.5],'k--');
Cl1 = plot([0,0.25*R*cos(gaq(1))],[0,0.25*R*sin(gaq(1))],'r','DisplayName','A','LineWidth',lw);
Cl2 = plot([0.25*R*cos(gaq(2)),0.5*R*cos(gaq(2))],[0.25*R*sin(gaq(2)),0.5*R*sin(gaq(2))],'g','DisplayName','B','LineWidth',lw);
Cl3 = plot([0.5*R*cos(gaq(3)),0.75*R*cos(gaq(3))],[0.5*R*sin(gaq(3)),0.75*R*sin(gaq(3))],'y','DisplayName','C','LineWidth',lw);
Cl4 = plot([0.75*R*cos(gaq(4)),R*cos(gaq(4))],[0.75*R*sin(gaq(4)),R*sin(gaq(4))],'b','DisplayName','D','LineWidth',lw);
t16 = text(5.5,0,'0^o     X_E','FontSize',fs);
t17 = text(-7,0,'180^o','FontSize',fs);
t18 = text(0,+6,'90^o     Z_E','FontSize',fs);
t19 = text(0,-6,'-90^o','FontSize',fs);
t20 = text(-7,7.5,strcat('A:   ',num2str(gaq(1)*180/pi),'^{o}'),'FontSize',fs);
t21 = text(-3,7.5,strcat('B:   ',num2str(gaq(2)*180/pi),'^{o}'),'FontSize',fs);
t22 = text(1,7.5,strcat('C:   ',num2str(gaq(3)*180/pi),'^{o}'),'FontSize',fs);
t23 = text(5,7.5,strcat('D:   ',num2str(gaq(4)*180/pi),'^{o}'),'FontSize',fs);
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'ZTick',[]);
set(gca,'Yticklabel',[]); 
set(gca,'Xticklabel',[]);
set(gca,'Zticklabel',[]); 
lgnd = legend(SubP2,[Cl1,Cl2,Cl3,Cl4],'Location','none','FontSize',fs);
set(lgnd, 'Position', [0.6524 0.2185 0.0410 0.1185])
hold off

%%






%%

f1 = sprintf('%s_WISE+turntable_%s.txt',num2str(ANGLE),datestr(now,'mm-dd-yyyy HH-MM'));
fwrite = fopen(f1,'wt');
time = 0;
while time<=ttotal
tic;
    switch (WISESENSORID)
        case 'A,B,C,D'
           [q2,q3,q4,q5,q1] = TransfDataReceive(ser,q2,q3,q4,q5,q1);
           
    end
    
[~,I1(1),I1(2),I1(3)] = parts(quaternion(quatmultiply(q1,quatmultiply(qI,quatconj(q1)))));
[~,J1(1),J1(2),J1(3)] = parts(quaternion(quatmultiply(q1,quatmultiply(qJ,quatconj(q1)))));
[~,K1(1),K1(2),K1(3)] = parts(quaternion(quatmultiply(q1,quatmultiply(qK,quatconj(q1)))));

[~,I2(1),I2(2),I2(3)] = parts(quaternion(quatmultiply(q2,quatmultiply(qI,quatconj(q2)))));
[~,J2(1),J2(2),J2(3)] = parts(quaternion(quatmultiply(q2,quatmultiply(qJ,quatconj(q2)))));
[~,K2(1),K2(2),K2(3)] = parts(quaternion(quatmultiply(q2,quatmultiply(qK,quatconj(q2)))));

[~,I3(1),I3(2),I3(3)] = parts(quaternion(quatmultiply(q3,quatmultiply(qI,quatconj(q3)))));
[~,J3(1),J3(2),J3(3)] = parts(quaternion(quatmultiply(q3,quatmultiply(qJ,quatconj(q3)))));
[~,K3(1),K3(2),K3(3)] = parts(quaternion(quatmultiply(q3,quatmultiply(qK,quatconj(q3)))));

[~,I4(1),I4(2),I4(3)] = parts(quaternion(quatmultiply(q4,quatmultiply(qI,quatconj(q4)))));
[~,J4(1),J4(2),J4(3)] = parts(quaternion(quatmultiply(q4,quatmultiply(qJ,quatconj(q4)))));
[~,K4(1),K4(2),K4(3)] = parts(quaternion(quatmultiply(q4,quatmultiply(qK,quatconj(q4)))));

[~,I5(1),I5(2),I5(3)] = parts(quaternion(quatmultiply(q5,quatmultiply(qI,quatconj(q5)))));
[~,J5(1),J5(2),J5(3)] = parts(quaternion(quatmultiply(q5,quatmultiply(qJ,quatconj(q5)))));
[~,K5(1),K5(2),K5(3)] = parts(quaternion(quatmultiply(q5,quatmultiply(qK,quatconj(q5)))));


theta1 = Simple_JCS(AX,q1,q2);
theta2 = Simple_JCS(AX,q1,q3);
theta3 = Simple_JCS(AX,q1,q4);
theta4 = Simple_JCS(AX,q1,q5);


figure(1)
hold on

subplot(2,1,1)
hold on
delete([E1,E2,E3,Et1,Et2,Et3,Et4,A1,A2,A3,At1,At2,At3,At4,B1,B2,B3,Bt1,Bt2,Bt3,Bt4,C1,C2,C3,Ct1,Ct2,Ct3,Ct4,D1,D2,D3,Dt1,Dt2,Dt3,Dt4])
% grid on
E1 = plot3([-3*sp,I1(1)-3*sp],[0,I1(2)],[0,I1(3)],'r','LineWidth',lw);  
E2 = plot3([-3*sp,J1(1)-3*sp],[0,J1(2)],[0,J1(3)],'g','LineWidth',lw);
E3 = plot3([-3*sp,K1(1)-3*sp],[0,K1(2)],[0,K1(3)],'b','LineWidth',lw);
Et1 = text(-0.5-3*sp,0,-0.1,'E','FontSize',fs);
Et2 = text(I1(1)-3*sp,I1(2),I1(3),'X','FontSize',fs);
Et3 = text(J1(1)-3*sp,J1(2),J1(3),'Y','FontSize',fs);
Et4 = text(K1(1)-3*sp,K1(2),K1(3),'Z','FontSize',fs);

A1 = plot3([-2*sp,-2*sp+I2(1)],[0,I2(2)],[0,I2(3)],'r','LineWidth',lw);
A2 = plot3([-2*sp,-2*sp+J2(1)],[0,J2(2)],[0,J2(3)],'g','LineWidth',lw);
A3 = plot3([-2*sp,-2*sp+K2(1)],[0,K2(2)],[0,K2(3)],'b','LineWidth',lw);
At1 = text(-0.5-2*sp,0,-0.1,'A','FontSize',fs);
At2 = text(-2*sp+I2(1),I2(2),I2(3),'X','FontSize',fs);
At3 = text(-2*sp+J2(1),J2(2),J2(3),'Y','FontSize',fs);
At4 = text(-2*sp+K2(1),K2(2),K2(3),'Z','FontSize',fs);

B1 = plot3([-1*sp,-1*sp+I3(1)],[0,I3(2)],[0,I3(3)],'r','LineWidth',lw);
B2 = plot3([-1*sp,-1*sp+J3(1)],[0,J3(2)],[0,J3(3)],'g','LineWidth',lw);
B3 = plot3([-1*sp,-1*sp+K3(1)],[0,K3(2)],[0,K3(3)],'b','LineWidth',lw);
Bt1 = text(-0.5-1*sp,0,-0.1,'B','FontSize',fs);
Bt2 = text(-1*sp+I3(1),I3(2),I3(3),'X','FontSize',fs);
Bt3 = text(-1*sp+J3(1),J3(2),J3(3),'Y','FontSize',fs);
Bt4 = text(-1*sp+K3(1),K3(2),K3(3),'Z','FontSize',fs);

C1 = plot3([0,I4(1)],[0,I4(2)],[0,I4(3)],'r','LineWidth',lw);  
C2 = plot3([0,J4(1)],[0,J4(2)],[0,J4(3)],'g','LineWidth',lw);C3 = plot3([0,K4(1)],[0,K4(2)],[0,K4(3)],'b','LineWidth',lw);
Ct1 = text(-0.50,0,-0.1,'C','FontSize',fs);
Ct2 = text(I4(1),I4(2),I4(3),'X','FontSize',fs);
Ct3 = text(J4(1),J4(2),J4(3),'Y','FontSize',fs);
Ct4 = text(K4(1),K4(2),K4(3),'Z','FontSize',fs);

D1 = plot3([sp,sp+I5(1)],[0,I5(2)],[0,I5(3)],'r','LineWidth',lw);  
D2 = plot3([sp,sp+J5(1)],[0,J5(2)],[0,J5(3)],'g','LineWidth',lw);
D3 = plot3([sp,sp+K5(1)],[0,K5(2)],[0,K5(3)],'b','LineWidth',lw);
Dt1 = text(sp-0.50,0,-0.1,'D','FontSize',fs);
Dt2 = text(sp+I5(1),I5(2),I5(3),'X','FontSize',fs);
Dt3 = text(sp+J5(1),J5(2),J5(3),'Y','FontSize',fs);
Dt4 = text(sp+K5(1),K5(2),K5(3),'Z','FontSize',fs);

hold off

subplot(2,1,2)
hold on
delete([t16,t17,t18,t19,t20,Cl1,Cl2,Cl3,Cl4,t21,t22,t23])
% grid on
axis equal
axis([-8 8 -8 8])
Cl1 = plot([0,0.25*R*cosd(theta1)],[0,0.25*R*sind(theta1)],'r','LineWidth',lw);
Cl2 = plot([0.25*R*cosd(theta2),0.5*R*cosd(theta2)],[0.25*R*sind(theta2),0.5*R*sind(theta2)],'g','LineWidth',lw);
Cl3 = plot([0.5*R*cosd(theta3),0.75*R*cosd(theta3)],[0.5*R*sind(theta3),0.75*R*sind(theta3)],'y','LineWidth',lw);
Cl4 = plot([0.75*R*cosd(theta4),R*cosd(theta4)],[0.75*R*sind(theta4),1*R*sind(theta4)],'b','LineWidth',lw);
t16 = text(5.5,0,'0^o','FontSize',fs);
t17 = text(-6.5,0,'180^o','FontSize',fs);
t18 = text(0,+5.5,'90^o','FontSize',fs);
t19 = text(0,-5.5,'-90^o','FontSize',fs);
t20 = text(-7,7.5,strcat('A:  ',num2str(theta1),'^{o}'),'FontSize',fs);
t21 = text(-3,7.5,strcat('B:  ',num2str(theta2),'^{o}'),'FontSize',fs);
t22 = text(1,7.5,strcat('C:  ',num2str(theta3),'^{o}'),'FontSize',fs);
t23 = text(5,7.5,strcat('D:  ',num2str(theta4),'^{o}'),'FontSize',fs);
hold off

fprintf(fwrite,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',time,q1(1),q1(2),q1(3),q1(4),q2(1),q2(2),q2(3),q2(4),q3(1),q3(2),q3(3),q3(4),q4(1),q4(2),q4(3),q4(4),theta1,theta2,theta3,theta4);

time = time+toc;

if ~isempty(k)
       if strcmp(k,'q') 
           k=[];
           fclose(fwrite);
           break; 
        end
end      
       pause(0.01)
end
fclose(fwrite);