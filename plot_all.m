%% experiment_fix_p_sweep_n_small
clc
clear
close all

% mat/experiments_fixP_sweepN_small_14-Jul-2017.mat
% mat/experiments2_fixP_sweepN_small_19-Jul-2017.mat
% mat/experiments_fixP_sweepN_small_19-Jul-2017.mat
load mat/experiments2_fixP_sweepN_small_19-Jul-2017.mat

lw = 4;
ms = 25;
fs = 20;

i_kron = 1;
i_cosamp = 2;
i_omp = 3;
i_akron = 4;
i_akronoi = 5;
i_l1 = 6;
i_l1n = 7;
i_sl0 = 8;
i_irwls = 9;

m_kron = 'ro-';
m_akron = 'c*-';
m_akronoi = 'c*-';
m_cosamp = 'b>-';
m_omp = 'k^-';
m_sl0 = 'rp-';
m_l1 = 'gs-';
m_l1n = 'gs-';
m_irwls = 'md-';


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
plot(Ps, errs_clean(i_irwls, :), m_irwls, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
ylim([0 1.5])
legend('KRON', 'AKRON', 'L1', 'OMP', 'CoSaMP', 'SL0', 'IRL1M', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('reconstruction error', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h1, 'eps/experiments_fixP_sweepN_small_errors.eps', 'eps2c');


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
plot(Ps, errs_clean_2(i_irwls, :), m_irwls, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
legend('KRON', 'AKRON', 'L1', 'OMP', 'CoSaMP', 'SL0', 'IRL1M', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('stability', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h2, 'eps/experiments_fixP_sweepN_small_stability.eps', 'eps2c');



h3 = figure;
hold on; 
box on; 
grid on;
% plot(Ps, errs_noise(i_kron, :), m_kron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_akronoi, :), m_akronoi, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_l1n, :), m_l1n, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_omp, :), m_omp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_cosamp, :), m_cosamp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_sl0, :), m_sl0, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise(i_irwls, :), m_irwls, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
ylim([0 1.5])
legend('AKRONoi', 'L1', 'OMP', 'CoSaMP', 'SL0', 'IRL1M', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('reconstruction error', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h3, 'eps/experiments_fixP_sweepN_small_errors_noise.eps', 'eps2c');


h4 = figure;
hold on; 
box on; 
grid on;
% plot(Ps, errs_noise_2(i_kron, :), m_kron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_akronoi, :), m_akronoi, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_l1n, :), m_l1n, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_omp, :), m_omp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_cosamp, :), m_cosamp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_sl0, :), m_sl0, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, errs_noise_2(i_irwls, :), m_irwls, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
legend('AKRONoi', 'L1', 'OMP', 'CoSaMP', 'SL0', 'IRL1M', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('stability', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h4, 'eps/experiments_fixP_sweepN_small_stability_noise.eps', 'eps2c');


h5 = figure;
hold on; 
box on; 
grid on;
plot(Ps, timez_A(1, :), m_kron, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, timez_A(4, :), m_akronoi, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, timez_A(5, :), m_l1n, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, timez_A(3, :), m_omp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, timez_A(2, :), m_cosamp, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, timez_A(7, :), m_sl0, 'LineWidth', lw, 'MarkerSize', ms);
plot(Ps, timez_A(8, :), m_irwls, 'LineWidth', lw, 'MarkerSize', ms);
axis tight;
legend('KRON', 'AKRON', 'L1', 'OMP', 'CoSaMP', 'SL0', 'IRL1M', 'Location', 'best')
xlabel('n', 'FontSize', fs);
ylabel('time', 'FontSize', fs);
set(gca, 'fontsize', fs);
saveas(h5, 'eps/experiments_fixP_sweepN_small_time.eps', 'eps2c');

%% experiment_larger_data.m
clc
clear
close all

% Z = {'mat/experiment_large_Gaussian_mp10_noise_25-Feb-2017.mat'
%   'mat/experiment_large_Gaussian_mp20_noise_25-Feb-2017.mat'
%   'mat/experiment_large_Gaussian_mp30_noise_26-Feb-2017.mat'
%   'mat/experiment_large_Gaussian_mp40_noise_26-Feb-2017.mat'};

Z = {'mat/experiment_large_Gaussian_mp10_noise_14-Jul-2017.mat'
  'mat/experiment_large_Gaussian_mp20_noise_15-Jul-2017.mat'
  'mat/experiment_large_Gaussian_mp30_noise_15-Jul-2017.mat'
  'mat/experiment_large_Gaussian_mp40_noise_16-Jul-2017.mat'};

for rr = 1:numel(Z)
  load(Z{rr});
  
  lw = 4;
  ms = 25;
  fs = 20;
  
  h = figure; 
  grid on;
  hold on;
  box on;
  plot(n_set, errs_no_norm(1, :), 'b>-', 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
  plot(n_set, errs_no_norm(2, :), 'k^-', 'LineWidth', lw, 'MarkerSize', ms) % OMP
  plot(n_set, errs_no_norm(3, :), 'c*-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
  plot(n_set, errs_no_norm(4, :), 'rp-', 'LineWidth', lw, 'MarkerSize', ms) % L1
  plot(n_set, errs_no_norm(5, :), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % SL0
  plot(n_set, errs_no_norm(6, :), 'md-', 'LineWidth', lw, 'MarkerSize', ms) % IRL1M
  % legend('CoSamp', 'AKRON', 'L1', 'Location', 'best')
  legend('CoSamp', 'OMP', 'AKRON', 'L1', 'SL0', 'IRL1M', 'Location', 'best')
  xlabel('n', 'FontSize', 20);
  ylabel('reconstruction error', 'FontSize', 20);
  box on;
  set(gca, 'fontsize', 20);
  saveas(h, ['eps/large_errors_',num2str(100*mp),'.eps'], 'eps2c')
  
  
  h = figure; 
  hold on;
  box on;
  grid on;
  plot(n_set, stabilities(1, :), 'b>-', 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
  plot(n_set, stabilities(2, :), 'k^-', 'LineWidth', lw, 'MarkerSize', ms) % OMP
  plot(n_set, stabilities(3, :), 'c*-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
  plot(n_set, stabilities(4, :), 'rp-', 'LineWidth', lw, 'MarkerSize', ms) % L1
  plot(n_set, stabilities(5, :), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % SL0
  plot(n_set, stabilities(6, :), 'md-', 'LineWidth', lw, 'MarkerSize', ms) % IRL1M
  legend('CoSamp', 'OMP', 'AKRON', 'L1', 'SL0', 'IRL1M', 'Location', 'best')
  xlabel('n', 'FontSize', 20);
  ylabel('stability', 'FontSize', 20);
  box on;
  set(gca, 'fontsize', 20);
  saveas(h, ['eps/large_stability_',num2str(100*mp),'.eps'], 'eps2c')
  
  h = figure; 
  grid on;
  hold on;
  box on;
  plot(n_set, timez(1, :), 'b>-', 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
  plot(n_set, timez(2, :), 'k^-', 'LineWidth', lw, 'MarkerSize', ms) % OMP
  plot(n_set, timez(3, :), 'c*-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
  plot(n_set, timez(4, :), 'rp-', 'LineWidth', lw, 'MarkerSize', ms) % AKRON
  plot(n_set, timez(5, :), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % SL0
  plot(n_set, timez(6, :), 'md-', 'LineWidth', lw, 'MarkerSize', ms) % IRL1M
  % plot(n_set, log(timez(4, :)), 'gs-', 'LineWidth', lw, 'MarkerSize', ms) % L1
  legend('CoSamp', 'OMP', 'AKRON', 'L1', 'SL0', 'IRL1M', 'Location', 'best')
  xlabel('n', 'FontSize', 20);
  ylabel('evaluation time', 'FontSize', 20);
  box on;
  set(gca, 'fontsize', 20);
  saveas(h, ['eps/large_timess_',num2str(100*mp),'.eps'], 'eps2c')
  
  close all;
  clearvars -except rr Z
end

%% plot times 
clc
clear
close all

load('mat/timerz_fix_p.mat');

lw = 4;
ms = 25;
fs = 20;

i_kron = 1;
i_akron = 4;
i_akronoi = 6;
i_cosamp = 2;
i_omp = 3;
i_sl0 = 8;
i_l1 = 5;
i_l1n = 7;

m_kron = 'ro-';
m_akron = 'c*-';
m_akronoi = 'c*-';
m_cosamp = 'b>-';
m_omp = 'k^-';
m_sl0 = 'rp-';
m_l1 = 'gs-';
m_l1n = 'gs-';
m_irwls = 'bd-';


h = figure; 
grid on;
hold on;
box on;
plot(Ms, timez_A(1, :), m_cosamp, 'LineWidth', lw, 'MarkerSize', ms) % CoSaMP
plot(Ms, timez_A(2, :), m_omp, 'LineWidth', lw, 'MarkerSize', ms) % OMP
plot(Ms, timez_A(3, :), m_akron, 'LineWidth', lw, 'MarkerSize', ms) % AKRON
plot(Ms, timez_A(4, :), m_l1, 'LineWidth', lw, 'MarkerSize', ms) % AKRON
plot(Ms, timez_A(5, :), m_sl0, 'LineWidth', lw, 'MarkerSize', ms) % SL0
plot(Ms, timez_A(6, :), m_irwls, 'LineWidth', lw, 'MarkerSize', ms) % SL0
legend('CoSamp', 'OMP', 'AKRON', 'L1', 'SL0', 'IRL1M', 'Location', 'best')
xlabel('n', 'FontSize', 20);
ylabel('evaluation time', 'FontSize', 20);
box on;
set(gca, 'fontsize', 20);
saveas(h, ['eps/times_fix_p.eps'], 'eps2c')


