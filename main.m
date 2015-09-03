%Lets make a car simulator
clc;
clear all;
close all;

%Vehicle Geometry
%The length of car as a whole is a+b
global a;
a =  0.6;
global b;
b = 0.4;
l = a+b;
global width;%Width of vehicle
width = .5;
global over;%Overshoot for wheel loc.
over = 0.05;
global wheellngth;%Length of wheel
wheellngth = 0.25;

%Initial co:ordinates(Source)
Xi = 0;
Yi = 0;
Thetai = 0.0;
psi = 0.0;
intl = [Xi,Yi,Thetai];

%Final co:ordinates(Destination)
Xf = 7;
Yf = 7;
Thetaf = pi;
dsrd = [Xf,Yf,Thetaf];

axis ([-5 15 -5 15]);
hold on;

%Mark locations
Drwprkbx(intl);
scatter(intl(1),intl(2),10,'filled','red');
Drwprkbx(dsrd);
scatter(dsrd(1),dsrd(2),10,'filled','red');
fprintf('Plotting source and destination\n');
pause(1);

%Draw path
conpoints = path(intl,dsrd);
fprintf('Sketching trajectory\n');
pause(1);

%Draw the car
H = DrwCar(intl,psi);
fprintf('Press enter to Drive\n');
pause;

prev = intl;
for mov = 2:size(conpoints,2)
    
    jntvar = invkin2(prev,conpoints(:,mov))
    delete(H);
    H = DrwCar(prev,jntvar(2));
    drawnow;
    pause(0.1);
    %input('set steering');
    
    attnd = fwdkin(prev,jntvar)
    delete(H);
    H = DrwCar(attnd,jntvar(2));
    drawnow;
    pause(0.2);
    %input('wait');
    prev = attnd;
    
end

disp('Goal reached');


    
    
    
    
