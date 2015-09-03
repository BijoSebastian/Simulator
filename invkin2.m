function [ sol ] = invkin2( intl,dsrd )
%Inverse kinematic solver
%Initial task space co:ordinates in intl.
%Desired task space co:ordinates in dsrd.
%Refer IK4CAR for more details.


%Vehicle Geometry
%global a;
%global b;
%l = a+b;
%global width;
%global over;
%global wheellngth;

%set limits
stlinedist = errcal(dsrd,[intl(1) intl(2)]);
d_min = stlinedist;
d_max = stlinedist*pi;
psi_min = -(pi/3);
psi_max = (pi/3);

%set std dev. of gaussian prob func.
stderr = 0.1;
%set spread while resampling
ressprd = 1;

%Lets populate
%Set number of particles
N = 1000;
particles = zeros(2,N);
range = 10.0;
for pno = 1:N
    particles(1,pno) = rand*(range);
    particles(2,pno) = rand*(range);
end
wgt = zeros(N,1);

%Setting weights on each particle
    for pno = 1:N
        
        %modify to original parameters
        modfy(1) =  (particles(1,pno)*((d_max - d_min)/range)) + d_min;
        modfy(2) =  (particles(2,pno)*((psi_max - psi_min)/range)) + psi_min;
        
        %Calculate frwd kinematic of particle
        attnd = fwdkin(intl,modfy);
        
        %Calculate error of particle
        err = errcal(dsrd,[attnd(1),attnd(2)]);
        
        %Calculate weight of particle
        wgt(pno) = Gaussian(err,stderr);
        
    end
    
    %Resampling
    while(sum(std(particles,0,2)) > 0.1)
        newparticles = zeros(2,N);
        newwgt = zeros(N,1);
        idx = randi(N);
        beta = 0.0;
        mw = max(wgt);
        
        for i = 1:N
            beta = beta + rand*2.0*mw;
            
            while (beta >= wgt(idx))
                beta = beta - wgt(idx);
                idx = mod(idx+1,N);
                if (idx == 0)
                    idx = 1;
                end
            end
            newparticles(:,i) = particles(:,idx);
            newwgt(i) = wgt(idx);
        end
        particles = newparticles;
        wgt = newwgt;
    end

    %Repopulate
    for pno = 1:N
        particles(1,pno) = particles(1,pno) + randn*ressprd;
        particles(2,pno) = particles(2,pno) + randn*ressprd;
    end            
    
    %Setting weights on each particle
    for pno = 1:N
        
        %modify to original parameters
        modfy(1) =  (particles(1,pno)*((d_max - d_min)/range)) + d_min;
        modfy(2) =  (particles(2,pno)*((psi_max - psi_min)/range)) + psi_min;
        
        %Calculate frwd kinematic of particle
        attnd = fwdkin(intl,modfy);
        
        %Calculate error of particle
        err = errcal(dsrd,attnd);
        
        %Calculate weight of particle
        wgt(pno) = Gaussian(err,stderr);              
        
    end
    
    %Resampling
    while( sum(std(particles,0,2)) > 0.1)
        newparticles = zeros(2,N);
        newwgt = zeros(N,1);
        idx = randi(N);
        beta = 0.0;
        mw = max(wgt);
    
        for i = 1:N
            beta = beta + rand*2.0*mw;
        
            while (beta >= wgt(idx))
                beta = beta - wgt(idx);
                idx = mod(idx+1,N);
                if (idx == 0)
                    idx = 1;
                end
            end
        
            newparticles(:,i) = particles(:,idx);
            newwgt(i) = wgt(idx);
        end
    
        particles = newparticles;
        wgt = newwgt;
    end    
    
%particles
sol(1) = (particles(1,pno)*((d_max - d_min)/range)) + d_min;
sol(2) = (particles(2,pno)*((psi_max - psi_min)/range)) + psi_min;


end


