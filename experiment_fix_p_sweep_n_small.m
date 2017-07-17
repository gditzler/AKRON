clc;
clear;
close all;

rng(1);

addpath('akron/');
addpath('other/');
addpath('sl0/');

n_avg = 250;
p = 20;
k = 8;      %floor(.05*n);
Ps = 7:19; %floor([.05 .1 .15 .2 .25 .3 .35]*n);
P = length(Ps);
k_alg = 8;
epsilon = 0.05;
max_iter = 50;

delete(gcp('nocreate'));
parpool(40);

alg = 9;
errs_clean = zeros(alg, P);
errs_noise = zeros(alg, P);
errs_clean_unit = zeros(alg, P);
errs_noise_unit = zeros(alg, P);
timez_A = zeros(alg, P);

errs_clean_2 = zeros(alg, P);
errs_noise_2 = zeros(alg, P);
errs_clean_unit_2 = zeros(alg, P);
timez_B = zeros(alg, P);


opts.printEvery = 10000000;
errFcn = [];

for i = 1:n_avg
  disp(['Running trial ',num2str(i), ' of ', num2str(n_avg)]);

  mm = 1;
  for n = Ps
    
    % generate data from the Gaussian CS model 
    [A, x, y] = cs_model(n, p, k, 'Gaussian');
    
    % run kernel reconstruction (kron)
    [~, ~, x_kron_spar, ~, ~, ~, tmz] = kron_cs(A, x, y);
    timez_A(1, mm) = timez_A(1, mm) + tmz;
    
    % run cosamp
    tic; 
    x_cosamp = cosamp(A, y, k_alg, errFcn, opts);
    timez_A(2, mm) = timez_A(2, mm) + toc;
    
    % run omp
    tic; 
    x_omp = omp(A, y, k_alg, errFcn, opts);
    timez_A(3, mm) = timez_A(3, mm) + toc;
    
    % run akron 
    [x_akron, x_l1, ~, tmz, tmzl1] = akron(A, y);
    timez_A(4, mm) = timez_A(4, mm) + tmz;
    timez_A(5, mm) = timez_A(5, mm) + tmzl1;
    
    % run akron-noisy
    [x_akronnoi, x_l1n, ~, tmz] = akronoi(A, y, epsilon);
    timez_A(6, mm) = timez_A(6, mm) + tmz;
    
    % run sl0
    tic;
    x_sl0 = SL0(A, y, 0.00001);
    timez_A(7, mm) = timez_A(7, mm) + toc;
    
    % run irwls
    tic;
    x_irwls = irwls(A, y, max_iter, 1e-3);
    timez_A(8, mm) = timez_A(8, mm) + toc;

    errs_clean(1, mm) = errs_clean(1, mm) + per_error(x, x_kron_spar);
    errs_clean(2, mm) = errs_clean(2, mm) + per_error(x, x_cosamp);
    errs_clean(3, mm) = errs_clean(3, mm) + per_error(x, x_omp);
    errs_clean(4, mm) = errs_clean(4, mm) + per_error(x, x_akron);
    errs_clean(5, mm) = errs_clean(5, mm) + per_error(x, x_akronnoi);
    errs_clean(6, mm) = errs_clean(6, mm) + per_error(x, x_l1);
    errs_clean(7, mm) = errs_clean(7, mm) + per_error(x, x_l1n);
    errs_clean(8, mm) = errs_clean(8, mm) + per_error(x, x_sl0);
    errs_clean(9, mm) = errs_clean(9, mm) + per_error(x, x_irwls);
    
    DELTA = 1e-3;
    x_ind = find(abs(x) > DELTA);
    errs_clean_2(1, mm) = errs_clean_2(1, mm) + stability_error(x_ind, find(abs(x_kron_spar) > DELTA), p);
    errs_clean_2(2, mm) = errs_clean_2(2, mm) + stability_error(x_ind, find(abs(x_cosamp) > DELTA), p);
    errs_clean_2(3, mm) = errs_clean_2(3, mm) + stability_error(x_ind, find(abs(x_omp) > DELTA), p);
    errs_clean_2(4, mm) = errs_clean_2(4, mm) + stability_error(x_ind, find(abs(x_akron) > DELTA), p);
    errs_clean_2(5, mm) = errs_clean_2(5, mm) + stability_error(x_ind, find(abs(x_akronnoi) > DELTA), p);
    errs_clean_2(6, mm) = errs_clean_2(6, mm) + stability_error(x_ind, find(abs(x_l1) > DELTA), p);
    errs_clean_2(7, mm) = errs_clean_2(7, mm) + stability_error(x_ind, find(abs(x_l1n) > DELTA), p);
    errs_clean_2(8, mm) = errs_clean_2(8, mm) + stability_error(x_ind, find(abs(x_sl0) > DELTA), p);
    errs_clean_2(9, mm) = errs_clean_2(9, mm) + stability_error(x_ind, find(abs(x_irwls) > DELTA), p);
    
    % generate noisy data s
    [A, x, y] = cs_model(n, p, k, 'GaussianNoise');
    
    % run kernel reconstruction (kron)
    [~, ~, x_kron_spar, ~, ~, ~, tmz] = kron_cs(A, x, y);
    timez_B(1, mm) = timez_B(1, mm) + tmz;
    
    % run cosamp
    tic; 
    x_cosamp = cosamp(A, y, k_alg, errFcn, opts);
    timez_B(2, mm) = timez_B(2, mm) + toc;
    
    % run omp
    tic; 
    x_omp = omp(A, y, k_alg, errFcn, opts);
    timez_B(3, mm) = timez_B(3, mm) + toc;
    
    % run akron 
    [x_akron, x_l1, ~, tmz, tmzl1] = akron(A, y);
    timez_B(4, mm) = timez_B(1, mm) + tmz;
    timez_B(5, mm) = timez_B(1, mm) + tmzl1;
    
    % run akron-noisy
    timez_B(6, mm) = timez_B(1, mm) + tmz;
    [x_akronnoi, x_l1n, ~, tmz] = akronoi2(A, y, epsilon);
    
    % run sl0
    tic;
    x_sl0 = SL0(A, y, 0.00001);
    timez_B(7, mm) = timez_B(7, mm) + toc;
    
    % run irwls
    tic;
    x_irwls = irwls(A, y, max_iter, 1e-3);
    timez_A(8, mm) = timez_A(8, mm) + toc;

    errs_noise(1, mm) = errs_noise(1, mm) + per_error(x, x_kron_spar);
    errs_noise(2, mm) = errs_noise(2, mm) + per_error(x, x_cosamp);
    errs_noise(3, mm) = errs_noise(3, mm) + per_error(x, x_omp);
    errs_noise(4, mm) = errs_noise(4, mm) + per_error(x, x_akron);
    errs_noise(5, mm) = errs_noise(5, mm) + per_error(x, x_akronnoi);
    errs_noise(6, mm) = errs_noise(6, mm) + per_error(x, x_l1);
    errs_noise(7, mm) = errs_noise(7, mm) + per_error(x, x_l1n);
    errs_noise(8, mm) = errs_noise(8, mm) + per_error(x, x_sl0);
    errs_noise(9, mm) = errs_noise(9, mm) + per_error(x, x_irwls);
    
    x_ind = find(abs(x) > DELTA);
    errs_noise_2(1, mm) = errs_noise_2(1, mm) + stability_error(x_ind, find(abs(x_kron_spar) > DELTA), p);
    errs_noise_2(2, mm) = errs_noise_2(2, mm) + stability_error(x_ind, find(abs(x_cosamp) > DELTA), p);
    errs_noise_2(3, mm) = errs_noise_2(3, mm) + stability_error(x_ind, find(abs(x_omp) > DELTA), p);
    errs_noise_2(4, mm) = errs_noise_2(4, mm) + stability_error(x_ind, find(abs(x_akron) > DELTA), p);
    errs_noise_2(5, mm) = errs_noise_2(5, mm) + stability_error(x_ind, find(abs(x_akronnoi) > DELTA), p);
    errs_noise_2(6, mm) = errs_noise_2(6, mm) + stability_error(x_ind, find(abs(x_l1) > DELTA), p);
    errs_noise_2(7, mm) = errs_noise_2(7, mm) + stability_error(x_ind, find(abs(x_l1n) > DELTA), p);
    errs_noise_2(8, mm) = errs_noise_2(8, mm) + stability_error(x_ind, find(abs(x_sl0) > DELTA), p);
    errs_noise_2(9, mm) = errs_noise_2(9, mm) + stability_error(x_ind, find(abs(x_irwls) > DELTA), p);
        
    mm = mm+1;
  end
  save('mat/timerz.mat');
end

errs_clean = errs_clean/n_avg;
errs_noise = errs_noise/n_avg;
errs_clean_unit = errs_clean_unit/n_avg;

errs_clean_2 = errs_clean_2/n_avg;
errs_noise_2 = errs_noise_2/n_avg;
errs_clean_unit_2 = errs_clean_unit_2/n_avg;

timez_A = timez_A/n_avg;
timez_B = timez_B/n_avg;
% var_errs_clean_2 = errs_clean_2 - errs_clean.^2;
% var_errs_noise_2 = errs_noise_2 - errs_noise.^2';
% var_errs_clean_unit_2 = errs_clean_unit_2 - errs_clean_unit.^2';
% var_errs_noise_unit_2 = errs_noise_unit_2 - errs_noise_unit.^2';
save(['mat/experiments_fixP_sweepN_small_', date, '.mat']);

