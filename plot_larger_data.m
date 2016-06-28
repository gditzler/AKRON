clc
clear
close all

load mat/large_Gaussian_mp10_noise.mat
errs = errs/i;
errs_no_norm = errs_no_norm/i;
sparsity = sparsity/i;
timez = timez/i;


%%
lw = 4;
ms = 30;
fs = 30;


%%
% CoSamp
% OMP   errs_no_norm
% AKRON
% L1
h = figure; 
grid on;
hold on;
box on;
plot(n_set, errs_no_norm(1, :), 'bs-', 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
plot(n_set, errs_no_norm(2, :), 'k^-', 'LineWidth', lw, 'MarkerSize', ms) % OMP
plot(n_set, errs_no_norm(3, :), 'cp-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
plot(n_set, errs_no_norm(4, :), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % L1
legend('CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best')
xlabel('n', 'FontSize', 20);
ylabel('reconstruction error', 'FontSize', 20);
box on;
set(gca, 'fontsize', 20);
saveas(h, ['eps/large_errors_',num2str(100*mp),'.eps'], 'eps2c')
%%
% CoSamp
% OMP   errs_no_norm
% AKRON
% L1
h = figure; 
hold on;
box on;
grid on;
plot(n_set, errs2(1, :), 'bs-', 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
plot(n_set, errs2(2, :), 'k^-', 'LineWidth', lw, 'MarkerSize', ms) % OMP
plot(n_set, errs2(3, :), 'cp-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
plot(n_set, errs2(4, :), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % L1
legend('CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best')
xlabel('n', 'FontSize', 20);
ylabel('stability', 'FontSize', 20);
box on;
set(gca, 'fontsize', 20);
saveas(h, ['eps/large_stability_',num2str(100*mp),'.eps'], 'eps2c')
