%% experiment_fix_p_sweep_n_small
clc
clear
close all

load experiments_fixP_sweepN_small_.mat


lw = 4;
ms = 30;
fs = 30;

i_kron = 1;
i_akron = 4;
i_akronoi = 6;
i_cosamp = 2;
i_opm = 3;
i_sl0 = 8;
i_l1 = 5;
i_l1n = 7;

m_kron = 'ro';
m_akron = 'c*';
m_akronoi = 'c*';
m_cosamp = 'b>';
m_opm = 'k^';
m_sl0 = 'rp';
m_l1 = 'gs';
m_l1n = 'gs';


h1 = figure;
hold on; 
box on; 
grid on;
plot(Ps, errs_clean(i_kron, :), m_kron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean(i_akron, :), m_akron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean(i_l1, :), m_l1, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean(i_omp, :), m_omp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean(i_cosamp, :), m_cosamp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean(i_sl0, :), m_sl0, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
legend('KRON', 'AKRON', 'L1', 'OMP', 'CoSaMP', 'SL0', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('reconstruction error', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h1, 'experiments_fixP_sweepN_small_errors.eps', 'eps2c');


h2 = figure;
hold on; 
box on; 
grid on;
plot(Ps, errs_clean_2(i_kron, :), m_kron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean_2(i_akron, :), m_akron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean_2(i_l1, :), m_l1, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean_2(i_omp, :), m_omp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean_2(i_cosamp, :), m_cosamp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_clean_2(i_sl0, :), m_sl0, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
legend('KRON', 'AKRON', 'L1', 'OMP', 'CoSaMP', 'SL0', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('stability', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h2, 'experiments_fixP_sweepN_small_stability.eps', 'eps2c');



h1 = figure;
hold on; 
box on; 
grid on;
plot(Ps, errs_noise(i_kron, :), m_kron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_akron, :), m_akron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_l1, :), m_l1, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_omp, :), m_omp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_cosamp, :), m_cosamp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_sl0, :), m_sl0, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
legend('KRON', 'AKRON', 'L1', 'OMP', 'CoSaMP', 'SL0', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('reconstruction error', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h1, 'experiments_fixP_sweepN_small_errors_noise.eps', 'eps2c');


h4 = figure;
hold on; 
box on; 
grid on;
plot(Ps, errs_noise_2(i_kron, :), m_kron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_akron, :), m_akron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_l1, :), m_l1, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_omp, :), m_omp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_cosamp, :), m_cosamp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_sl0, :), m_sl0, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
legend('KRON', 'AKRON', 'L1', 'OMP', 'CoSaMP', 'SL0', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('stability', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h4, 'experiments_fixP_sweepN_small_stability_noise.eps', 'eps2c');


