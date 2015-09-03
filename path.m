function [pathpar ] = path(sourc,dest)
%Bezier path planner.


%length of tangent
len = 1.0;
P0 = [sourc(1) sourc(2)];
P1(1) = P0(1) + len*cos(sourc(3));
P1(2) = P0(2) + len*sin(sourc(3));

P3 = [dest(1) dest(2)];
P2(1) = P3(1) - 20*len*cos(dest(3));
P2(2) = P3(2) - 20*len*sin(dest(3));

G1 = [P0; P1; P2; P3];
G = G1';
N = [1 -3 3 -1;0 3 -6 3;0 0 3 -3;0 0 0 1];
i=1;

num = 10.0;
pathpar = zeros(2,num);

for t = 0.0:1.0/num:1.0
    
    T = [ 1; t; t^2; t^3];
    P=G*N*T;
    pathpar(1,i)=P(1);
    pathpar(2,i)=P(2);
    i=i+1;
    
end

plot(pathpar(1,:),pathpar(2,:),'rx','MarkerSize',5);

end

