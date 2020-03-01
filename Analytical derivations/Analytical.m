
air_gap_small = 0.5*1e-3;
air_gap_large = 2.5*1e-3;
perm_air = 4*pi*1e-7;
core_depth = 20*1e-3;
theta_diff = asin(7.5/12);
r_large = 12*1e-3;
r_small = 10*1e-3;
turn_ratio = 250;
Req = zeros (1,1801);
R1 = zeros (1,1801);
R2 = zeros (1,1801);
L = zeros (1,1801);
theta = linspace(0,180,1801);
% Theta = 0
% R1 = 2*air_gap_small/(perm_air*((2*theta_diff)/(2*pi))*2*pi*r_large*core_depth);
% L1 = turn_ratio^2/R1;
% 
% % 102.64>Theta>38.68*2 
% R2 = 2*air_gap_large/(perm_air*((2*theta_diff)/(2*pi))*2*pi*r_small*core_depth);
% L2 = turn_ratio^2/R2;

for i=0:1:1800 %%0.1degree step
    if i == 0 | i == 1800
        Req(i+1) = 2*air_gap_small/(perm_air*((2*theta_diff)/(2*pi))*2*pi*r_large*core_depth);
        L(i+1) = turn_ratio^2/Req(i+1);
    elseif i > 0 & i < 774
        R1(i+1) = 2*air_gap_small/(perm_air*((2*theta_diff-i*pi/1800)/(2*pi))*2*pi*r_large*core_depth);
        R2(i+1) = 2*air_gap_large/(perm_air*((i*pi/1800)/(2*pi))*2*pi*r_small*core_depth);
        Req(i+1)= R1(i+1)*R2(i+1)/(R1(i+1)+R2(i+1));
        L(i+1) = turn_ratio^2/Req(i+1);
    elseif i>=774 & i< 1026
        Req(i+1) = 2*air_gap_large/(perm_air*((2*theta_diff)/(2*pi))*2*pi*r_small*core_depth);
        L(i+1) = turn_ratio^2/Req(i+1);
    elseif i< 1800
        R1(i+1) = 2*air_gap_small/(perm_air*(abs(pi-2*theta_diff-i*pi/1800)/(2*pi))*2*pi*r_large*core_depth);
        R2(i+1) = 2*air_gap_large/(perm_air*((pi-i*pi/1800)/(2*pi))*2*pi*r_small*core_depth);
        Req(i+1)= R1(i+1)*R2(i+1)/(R1(i+1)+R2(i+1));
        L(i+1) = turn_ratio^2/Req(i+1);
    end
    
end
plot(theta,L);
grid on;
xlabel('Theta (degree)');
ylabel('Inductance (H)');
title('Inductance of the System');
figure;

plot(theta,Req);
grid on;
xlabel('Theta (degree)');
ylabel('Reluctance (1/H)');
title('Reluctance of the System');

            