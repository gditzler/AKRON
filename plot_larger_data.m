clc
clear
close all

load mat/large_Gaussian_mp40_noise.mat
% only for mp10
% errs = errs/i;
% errs2 = errs2/n_avg;
% errs_no_norm = errs_no_norm/i;
% sparsity = sparsity/i;
% timez = timez/i;

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
% legend('CoSamp', 'AKRON', 'L1', 'Location', 'best')
legend('CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best')
xlabel('p', 'FontSize', 20);
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
plot(n_set, stability(1, :), 'bs-', 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
plot(n_set, stability(2, :), 'k^-', 'LineWidth', lw, 'MarkerSize', ms) % OMP
plot(n_set, stability(3, :), 'cp-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
plot(n_set, stability(4, :), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % L1
legend('CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best')
xlabel('p', 'FontSize', 20);
ylabel('stability', 'FontSize', 20);
box on;
set(gca, 'fontsize', 20);
saveas(h, ['eps/large_stability_',num2str(100*mp),'.eps'], 'eps2c')
%%
% CoSamp
% OMP   errs_no_norm
% AKRON
% L1
h = figure; 
grid on;
hold on;
box on;
plot(n_set, timez(1, :), 'bs-', 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
plot(n_set, timez(2, :), 'k^-', 'LineWidth', lw, 'MarkerSize', ms) % OMP
plot(n_set, timez(3, :), 'cp-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
% plot(n_set, log(timez(4, :)), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % L1
legend('CoSamp', 'OMP', 'AKRON', 'Location', 'best')
xlabel('p', 'FontSize', 20);
ylabel('evaluation time', 'FontSize', 20);
box on;
set(gca, 'fontsize', 20);
saveas(h, ['eps/large_timess_',num2str(100*mp),'.eps'], 'eps2c')
