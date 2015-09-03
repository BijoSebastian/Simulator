function [ attnd ] = fwdkin(intl,jntvar)
%Forward kinematic solver for a car
% 

%Vehicle Geometry
global a;
global b;
%global width;
%global over;
%global wheellngth;
l = a+b;

%Initial co:ordinates
Xi = intl(1);
Yi = intl(2);
Thetai = intl(3);

    d = jntvar(1);
    psi = jntvar(2);
    R = l/tan(psi);
        
    if(R<500)
        Betta = (d*tan(psi))/l;
        Thetaf = Thetai + Betta;
        Xf = Xi + (R*sin(Thetaf)) - (R*sin(Thetai)) + (b*cos(Thetaf)) - (b*cos(Thetai));
        Yf = Yi - (R*cos(Thetaf)) + (R*cos(Thetai)) + (b*sin(Thetaf)) - (b*sin(Thetai));
    else
        Thetaf = Thetai;
        Xf = Xi + d*cos(Thetaf);
        Yf = Yi + d*sin(Thetaf);
    end
    
    attnd(1) = Xf;
    attnd(2) = Yf;
    attnd(3) = Thetaf;
end

