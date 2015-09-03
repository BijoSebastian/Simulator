function [ ] = Drwprkbx( pos )
%Function to draw parking box for car
%Xc and Yc are the location of CG of car.
%Theta is the orientation of the car

%Vehicle Geometry
global a;
global b;
global width;
global over;
%global wheellngth;

Xc = pos(1);
Yc = pos(2);
theta = pos(3);

Fx = Xc + 2*a*cos(theta);
Fy = Yc + 2*a*sin(theta);
Bx = Xc - 2*b*cos(theta);
By = Yc - 2*b*sin(theta);

Blx = Bx - ((width/2)+3*over)*sin(theta);
Bly = By + ((width/2)+3*over)*cos(theta);
Brx = Bx + ((width/2)+3*over)*sin(theta);
Bry = By - ((width/2)+3*over)*cos(theta);
line([Blx Brx],[Bly Bry],'color','black');

Flx = Fx - ((width/2)+3*over)*sin(theta);
Fly = Fy + ((width/2)+3*over)*cos(theta);
Frx = Fx + ((width/2)+3*over)*sin(theta);
Fry = Fy - ((width/2)+3*over)*cos(theta);
line([Flx Frx],[Fly Fry],'color','black');

line([Flx Blx],[Fly Bly],'color','black');
line([Frx Brx],[Fry Bry],'color','black');

end

