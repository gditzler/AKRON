clc
clear 
close all

load mat/noise_experiments.mat
I = Ms;%5:M; %2:size(errs_no_norm,2);


% errs_noise(1, mm) = errs_noise(1, mm) + per_error(x, x_kr_spar);
% errs_noise(2, mm) = errs_noise(2, mm) + per_error(x, x_cosamp);
% errs_noise(3, mm) = errs_noise(3, mm) + per_error(x, x_omp);
% errs_noise(4, mm) = errs_noise(4, mm) + per_error(x, x_l1kr);
% errs_noise(5, mm) = errs_noise(5, mm) + per_error(x, x_l1krn);
% errs_noise(6, mm) = errs_noise(6, mm) + per_error(x, x_l1);
% errs_noise(7, mm) = errs_noise(7, mm) + per_error(x, x_l1n);

lw = 4;
ms = 30;
fs = 30;
%%
h = figure; 
hold on; grid on;
box on;
plot(I, errs_clean(1, 1:numel(I)), 'ro-', 'LineWidth', lw, 'MarkerSize', ms);%kr
plot(I, errs_clean(2, 1:numel(I)), 'b>-', 'LineWidth', lw, 'MarkerSize', ms);%cosamp
plot(I, errs_clean(3, 1:numel(I)), 'k^-', 'LineWidth', lw, 'MarkerSize', ms);%omp
plot(I, errs_clean(4, 1:numel(I)), 'cp-', 'LineWidth', lw, 'MarkerSize', ms);%akron
% plot(I, errs_clean(5, 1:numel(I)), 'ms-', 'LineWidth', 2);%akronoi
plot(I, errs_clean(6, 1:numel(I)), 'gs-', 'LineWidth', lw, 'MarkerSize', ms);%l1
% plot(I, errs_clean(7, 1:numel(I)), 'bo-', 'LineWidth', 2);%l1n
axis tight;
xlim([8, M])
ylim([0, 1.5])
% legend('KR', 'CoSamp', 'OMP', 'AKRON', 'AKRONoi', 'L1', 'L1n', 'Location', 'best');
% columnlegend(2, {'KRON', 'CoSamp', 'OMP', 'AKRON', 'L1'}, 'fontsize', 50);
legend('KRON', 'CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best');
xlabel('n', 'FontSize', fs);
ylabel('reconstruction error', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h, 'eps/noise_exp_clean.eps', 'eps2c')

%%
g = figure; 
hold on; grid on;
box on;
% plot(I, errs_noise(1, 1:numel(I)), 'ro-', 'LineWidth', lw, 'MarkerSize', ms);%kr
plot(I, errs_noise(2, 1:numel(I)), 'b>-', 'LineWidth', lw, 'MarkerSize', ms);%cosamp
plot(I, errs_noise(3, 1:numel(I)), 'k^-', 'LineWidth', lw, 'MarkerSize', ms);%omp
% plot(I, errs_noise(4, 1:numel(I)), 'cp-', 'LineWidth', lw, 'MarkerSize', ms);%akron
plot(I, errs_noise(5, 1:numel(I)), 'cp-', 'LineWidth', lw, 'MarkerSize', ms);%akronoi
% plot(I, errs_noise(6, 1:numel(I)), 'rs-', 'LineWidth', lw, 'MarkerSize', ms);%l1
plot(I, errs_noise(7, 1:numel(I)), 'gs-', 'LineWidth', lw, 'MarkerSize', ms);%l1n
xlim([8, M])
ylim([0, 1.5])
legend('CoSamp', 'OMP', 'AKRONoi', 'L1n', 'Location', 'best');
% legend('KR', 'CoSamp', 'OMP', 'AKRON', 'AKRONoi', 'Location', 'best');
xlabel('n', 'FontSize', fs);
ylabel('reconstruction error', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(g, 'eps/noise_exp_noise.eps', 'eps2c')
%%
h = figure; 
hold on; grid on;
box on;
plot(I, errs_clean_2(1, 1:numel(I)), 'ro-', 'LineWidth', lw, 'MarkerSize', ms);%kr
plot(I, errs_clean_2(2, 1:numel(I)), 'b>-', 'LineWidth', lw, 'MarkerSize', ms);%cosamp
plot(I, errs_clean_2(3, 1:numel(I)), 'k^-', 'LineWidth', lw, 'MarkerSize', ms);%omp
plot(I, errs_clean_2(4, 1:numel(I)), 'cp-', 'LineWidth', lw, 'MarkerSize', ms);%akron
% plot(I, errs_clean_2(5, 1:numel(I)), 'ms-', 'LineWidth', 2);%akronoi
plot(I, errs_clean_2(6, 1:numel(I)), 'gs-', 'LineWidth', lw, 'MarkerSize', ms);%l1
% plot(I, errs_clean_2(7, 1:numel(I)), 'bo-', 'LineWidth', 2);%l1n
axis tight;
xlim([8, M])
% ylim([0, 1.5])
% legend('KR', 'CoSamp', 'OMP', 'AKRON', 'AKRONoi', 'L1', 'L1n', 'Location', 'best');
legend('KRON', 'CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best');
xlabel('n', 'FontSize', fs);
ylabel('stability', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h, 'eps/noise_exp_clean_stability.eps', 'eps2c')
%%
h = figure; 
hold on; grid on;
box on;
% plot(I, errs_noise_2(1, 1:numel(I)), 'ro-', 'LineWidth', lw, 'MarkerSize', ms);%kr
plot(I, errs_noise_2(2, 1:numel(I)), 'b>-', 'LineWidth', lw, 'MarkerSize', ms);%cosamp
plot(I, errs_noise_2(3, 1:numel(I)), 'k^-', 'LineWidth', lw, 'MarkerSize', ms);%omp
% plot(I, errs_noise_2(4, 1:numel(I)), 'cp-', 'LineWidth', lw, 'MarkerSize', ms);%akron
plot(I, errs_noise_2(5, 1:numel(I)), 'cp-', 'LineWidth', lw, 'MarkerSize', ms);%akronoi
% plot(I, errs_noise_2(6, 1:numel(I)), 'rs-', 'LineWidth', lw, 'MarkerSize', ms);%l1
plot(I, errs_noise_2(7, 1:numel(I)), 'gs-', 'LineWidth', lw, 'MarkerSize', ms);%l1n
xlim([8, M])
% ylim([0, 1.5])
legend('CoSamp', 'OMP', 'AKRONoi', 'L1n', 'Location', 'best');
% legend('KR', 'CoSamp', 'OMP', 'AKRON', 'AKRONoi', 'Location', 'best');
xlabel('n', 'FontSize', fs);
ylabel('stability', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h, 'eps/noise_exp_noise_stability.eps', 'eps2c')

%%
h = figure; 
hold on; grid on;
box on;
% plot(I, errs_noise_2(1, 1:numel(I)), 'ro-', 'LineWidth', lw, 'MarkerSize', ms);%kr
% plot(I, timez_A(2, 1:numel(I)), 'b>-', 'LineWidth', lw, 'MarkerSize', ms);%cosamp
plot(I, timez_A(3, 1:numel(I)), 'k^-', 'LineWidth', lw, 'MarkerSize', ms);%omp
plot(I, timez_A(4, 1:numel(I)), 'cp-', 'LineWidth', lw, 'MarkerSize', ms);%akron
plot(I, timez_A(5, 1:numel(I)), 'rs-', 'LineWidth', lw, 'MarkerSize', ms);%l1
% plot(I, timez_A(6, 1:numel(I)), 'rs-', 'LineWidth', lw, 'MarkerSize', ms);%l1
% plot(I, timez_A(7, 1:numel(I)), 'gs-', 'LineWidth', lw, 'MarkerSize', ms);%l1n
% xlim([8, M])
% ylim([0, 1.5])
legend('OMP', 'AKRON', 'L1n', 'Location', 'best');
% legend('KR', 'CoSamp', 'OMP', 'AKRON', 'AKRONoi', 'Location', 'best');
xlabel('n', 'FontSize', fs);
ylabel('time', 'FontSize', fs);
set(gca, 'fontsize', fs);
% saveas(h, 'eps/noise_exp_noise_stability.eps', 'eps2c')
