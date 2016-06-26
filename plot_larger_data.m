clc
clear
close all

load mat/large_Gaussiank12.mat

lw = 2;
ms = 20;
fs = 20;


% CoSamp
% OMP
% AKRON
% L1
h = figure; 
hold on;
box on;
plot(n_set, errs(1,:), 'bs-', 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
plot(n_set, errs(2,:), 'k^-', 'LineWidth', lw, 'MarkerSize', ms) % OMP
plot(n_set, errs(3,:), 'cp-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
plot(n_set, errs(4,:), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % L1
legend('CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best')
xlabel('n', 'FontSize', 20);
ylabel('reconstruction error', 'FontSize', 20);
set(gca, 'fontsize', 20);
saveas(h, 'eps/large_Gaussiank12.eps', 'eps2c')
