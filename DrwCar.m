function [H] = DrwCar( pos,psi )
%Function for drawing a car
%Xc and Yc are the location of CG of car.
%Theta is the orientation of the car
%Psi is the steering orientation

%Vehicle Geometry
global a;
global b;
global width;
global over;
global wheellngth;


Xc = pos(1);
Yc = pos(2);
theta = pos(3);

h1 = scatter(Xc,Yc,30,'green','filled');

Fx = Xc + a*cos(theta);
Fy = Yc + a*sin(theta);
Bx = Xc - b*cos(theta);
By = Yc - b*sin(theta);
h2 = line([Fx Bx],[Fy By],'color','blue');

Blx = Bx - (width/2)*sin(theta);
Bly = By + (width/2)*cos(theta);
Brx = Bx + (width/2)*sin(theta);
Bry = By - (width/2)*cos(theta);
h3 = line([Blx Brx],[Bly Bry],'color','blue');

Flx = Fx - (width/2)*sin(theta);
Fly = Fy + (width/2)*cos(theta);
Frx = Fx + (width/2)*sin(theta);
Fry = Fy - (width/2)*cos(theta);
h4 = line([Flx Frx],[Fly Fry],'color','blue');

Blx = Bx - ((width/2) + over)*sin(theta);
Bly = By + ((width/2) + over)*cos(theta);
WBlfx = Blx + wheellngth*cos(theta);
WBlfy = Bly + wheellngth*sin(theta);
WBlbx = Blx - wheellngth*cos(theta);
WBlby = Bly - wheellngth*sin(theta);
h5 = line([WBlfx WBlbx],[WBlfy WBlby],'color','blue');

Brx = Bx + ((width/2) + over)*sin(theta);
Bry = By - ((width/2) + over)*cos(theta);
WBrfx = Brx + wheellngth*cos(theta);
WBrfy = Bry + wheellngth*sin(theta);
WBrbx = Brx - wheellngth*cos(theta);
WBrby = Bry - wheellngth*sin(theta);
h6 = line([WBrfx WBrbx],[WBrfy WBrby],'color','blue');

Flx = Fx - ((width/2) + over)*sin(theta);
Fly = Fy + ((width/2) + over)*cos(theta);
WFlfx = Flx + wheellngth*cos(theta + psi);
WFlfy = Fly + wheellngth*sin(theta + psi);
WFlbx = Flx - wheellngth*cos(theta + psi);
WFlby = Fly - wheellngth*sin(theta + psi);
h7 = line([WFlfx WFlbx],[WFlfy WFlby],'color','green');

Frx = Fx + ((width/2) + over)*sin(theta);
Fry = Fy - ((width/2) + over)*cos(theta);
WFrfx = Frx + wheellngth*cos(theta + psi);
WFrfy = Fry + wheellngth*sin(theta + psi);
WFrbx = Frx - wheellngth*cos(theta + psi);
WFrby = Fry - wheellngth*sin(theta + psi);
h8 = line([WFrfx WFrbx],[WFrfy WFrby],'color','green');

H = [h1 h2 h3 h4 h5 h6 h7 h8];