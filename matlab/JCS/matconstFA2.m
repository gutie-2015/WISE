clear all, close all, clc

ax = 5*pi/180;
ay = 7*pi/180;
az = -30*pi/180;

Rx = [1 0 0; 0 cos(ax) -sin(ax); 0 sin(ax) cos(ax)];
Ry = [cos(ay) 0 sin(ay); 0 1 0;-sin(ay) 0 cos(ay)];
Rz = [cos(az) -sin(az) 0; sin(az) cos(az) 0;0 0 1];

Rt = Rz*Ry*Rx;
R = Rt;
q = rotm2quat(R);

figure(1)
hold on
view([35,24])
axis equal
axis([-1 1 -1 1 -1 1])

X = plot3([0 1],[0 0],[0 0],'k');
TX = text(1,0,0,'i');
Y = plot3([0 0],[0 1],[0 0],'k');
TY = text(0,1,0,'j');
Z = plot3([0 0],[0 0],[0 1],'k');
TZ = text(0,0,1,'k');

R1 = plot3([0 R(1,1)],[0 R(2,1)],[0 R(3,1)],'r');
R2 = plot3([0 R(1,2)],[0 R(2,2)],[0 R(3,2)],'g');
R3 = plot3([0 R(1,3)],[0 R(2,3)],[0 R(3,3)],'b');

%% rotation around Z

ef = atan2(R(2,1),R(1,1));
qZ = [cos(ef/2),0,0,sin(ef/2)];
RZ = quat2rotm(qZ);
Rc = RZ;

q2 = quatmultiply(quatconj(qZ),q);
R = quat2rotm(q2);

figure(1)
delete([R1,R2,R3])
R1 = plot3([0 R(1,1)],[0 R(2,1)],[0 R(3,1)],'r');
R2 = plot3([0 R(1,2)],[0 R(2,2)],[0 R(3,2)],'g');
R3 = plot3([0 R(1,3)],[0 R(2,3)],[0 R(3,3)],'b');

disp('extension flexion')
disp(ef*180/pi)
%% rotation around Y

ps = atan2(-R(3,1),R(1,1));
qY = [cos(ps/2),0,sin(ps/2),0];
RY = quat2rotm(q2);
Rc = Rc*RY;

q2 = quatmultiply(quatconj(qY),q2);
R = quat2rotm(q2);

figure(1)
delete([R1,R2,R3])
R1 = plot3([0 R(1,1)],[0 R(2,1)],[0 R(3,1)],'r');
R2 = plot3([0 R(1,2)],[0 R(2,2)],[0 R(3,2)],'g');
R3 = plot3([0 R(1,3)],[0 R(2,3)],[0 R(3,3)],'b');

disp('pronation supination')
disp(ps*180/pi)

%% rotation around X

mo = atan2(R(3,2),R(2,2));
qX = [cos(mo/2),sin(mo/2),0,0];
RX = quat2rotm(qX);
Rc = Rc*RX;

q2 = quatmultiply(quatconj(qX),q2);
R = quat2rotm(q2);

figure(1)
delete([R1,R2,R3])
R1 = plot3([0 R(1,1)],[0 R(2,1)],[0 R(3,1)],'r');
R2 = plot3([0 R(1,2)],[0 R(2,2)],[0 R(3,2)],'g');
R3 = plot3([0 R(1,3)],[0 R(2,3)],[0 R(3,3)],'b');

disp('mounting offset')
disp(mo*180/pi)

disp(Rc)
disp(Rt)
