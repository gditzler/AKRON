clc
clear
close all

load mat/large_Gaussiank12.mat

% CoSamp
% OMP
% AKRON
% L1
h = figure; 
hold on;
box on;
plot(n_set, errs(1,:), 'bs-', 'LineWidth', 2)
plot(n_set, errs(2,:), 'k^-', 'LineWidth', 2)
plot(n_set, errs(3,:), 'cp-', 'LineWidth', 2)
plot(n_set, errs(4,:), 'rs-', 'LineWidth', 2)
legend('CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best')
xlabel('n', 'FontSize', 20);
ylabel('reconstruction error', 'FontSize', 20);
set(gca, 'fontsize', 20);
saveas(h, 'eps/large_Gaussiank12.eps', 'eps2c')
