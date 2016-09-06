clc;
clear;
close all;

rng(1);

addpath('akron/');
addpath('other/');

n_avg = 100;
n = 200;
k = floor(.05*n);
% M = n-3;
Ms = floor([.05 .1 .15 .2 .25 .3 .35]*n);
M = length(Ms);
k_alg = 15;
% k_alg = 9;
epsilon = 0.05;
delete(gcp('nocreate'));
parpool(90);


errs_clean = zeros(7, M);
errs_noise = zeros(7, M);
errs_clean_unit = zeros(7, M);
errs_noise_unit = zeros(7, M);
timez_A = zeros(7, M);

errs_clean_2 = zeros(7, M);
errs_noise_2 = zeros(7, M);
errs_clean_unit_2 = zeros(7, M);
timez_B = zeros(7, M);


opts.printEvery = 10000000;
errFcn = [];

for i = 1:n_avg
  disp(['Running trial ',num2str(i), ' of ', num2str(n_avg)]);

  mm = 1;
  for m = Ms
    
    % generate data from the Gaussian CS model 
    [A, x, y] = cs_model(m, n, k, 'Gaussian');
    
    % run kernel reconstruction (kron)
    %[~, ~, x_kron_spar, ~, ~, ~, tmz] = kron_cs(A, x, y);
    %timez_A(1, mm) = timez_A(1, mm) + tmz;
    
    % run cosamp
    disp('Running CoSaMP')
    tic; 
    x_cosamp = cosamp(A, y, k_alg, errFcn, opts);
    timez_A(2, mm) = timez_A(2, mm) + toc;
    
    % run omp
    tic; 
    x_omp = omp(A, y, k_alg, errFcn, opts);
    timez_A(3, mm) = timez_A(3, mm) + toc;
    
    % run akron 
    [x_akron, x_l1, ~, tmz, tmzl1] = akron(A, y);
    timez_A(4, mm) = timez_A(1, mm) + tmz;
    timez_A(5, mm) = timez_A(1, mm) + tmzl1;
    
    % run akron-noisy
%     timez_A(6, mm) = timez_A(1, mm) + tmz;
%     [x_akronnoi, x_l1n, ~, tmz] = akronoi(A, y, epsilon);

%     %errs_clean(1, mm) = errs_clean(1, mm) + per_error(x, x_kron_spar);
%     errs_clean(2, mm) = errs_clean(2, mm) + per_error(x, x_cosamp);
%     errs_clean(3, mm) = errs_clean(3, mm) + per_error(x, x_omp);
%     errs_clean(4, mm) = errs_clean(4, mm) + per_error(x, x_akron);
%     %errs_clean(5, mm) = errs_clean(5, mm) + per_error(x, x_akronnoi);
%     errs_clean(6, mm) = errs_clean(6, mm) + per_error(x, x_l1);
%     %errs_clean(7, mm) = errs_clean(7, mm) + per_error(x, x_l1n);
%     
%     DELTA = 1e-3;
%     x_ind = find(abs(x) > DELTA);
%     %errs_clean_2(1, mm) = errs_clean_2(1, mm) + stability_error(x_ind, find(abs(x_kron_spar) > DELTA), n);
%     errs_clean_2(2, mm) = errs_clean_2(2, mm) + stability_error(x_ind, find(abs(x_cosamp) > DELTA), n);
%     errs_clean_2(3, mm) = errs_clean_2(3, mm) + stability_error(x_ind, find(abs(x_omp) > DELTA), n);
%     errs_clean_2(4, mm) = errs_clean_2(4, mm) + stability_error(x_ind, find(abs(x_akron) > DELTA), n);
%     %errs_clean_2(5, mm) = errs_clean_2(5, mm) + stability_error(x_ind, find(abs(x_akronnoi) > DELTA), n);
%     errs_clean_2(6, mm) = errs_clean_2(6, mm) + stability_error(x_ind, find(abs(x_l1) > DELTA), n);
%     %errs_clean_2(7, mm) = errs_clean_2(7, mm) + stability_error(x_ind, find(abs(x_l1n) > DELTA), n);
%     
%     %errs_clean_unit(1, mm) = errs_clean_unit(1, mm) + per_error(x/norm(x), x_kron_spar/norm(x_kron_spar));
%     errs_clean_unit(2, mm) = errs_clean_unit(2, mm) + per_error(x/norm(x), x_cosamp/norm(x_cosamp));
%     errs_clean_unit(3, mm) = errs_clean_unit(3, mm) + per_error(x/norm(x), x_omp/norm(x_omp));
%     errs_clean_unit(4, mm) = errs_clean_unit(4, mm) + per_error(x/norm(x), x_akron/norm(x_akron));
%     %errs_clean_unit(5, mm) = errs_clean_unit(5, mm) + per_error(x/norm(x), x_akronnoi/norm(x_akronnoi));
%     errs_clean_unit(6, mm) = errs_clean_unit(6, mm) + per_error(x/norm(x), x_l1/norm(x_l1));
%     %errs_clean_unit(7, mm) = errs_clean_unit(7, mm) + per_error(x/norm(x), x_l1n/norm(x_l1n));
    

%     % generate noisy data s
%     [A, x, y] = cs_model(m, n, k, 'GaussianNoise');
%     
%     
%     % run kernel reconstruction (kron)
%     %[~, ~, x_kron_spar, ~, ~, ~, tmz] = kron_cs(A, x, y);
%     %timez_B(1, mm) = timez_B(1, mm) + tmz;
%     
%     % run cosamp
%     tic; 
%     x_cosamp = cosamp(A, y, k_alg, errFcn, opts);
%     timez_B(2, mm) = timez_B(2, mm) + toc;
%     
%     % run omp
%     tic; 
%     x_omp = omp(A, y, k_alg, errFcn, opts);
%     timez_B(3, mm) = timez_B(3, mm) + toc;
%     
%     % run akron 
%     [x_akron, x_l1, ~, tmz, tmzl1] = akron(A, y);
%     timez_B(4, mm) = timez_B(1, mm) + tmz;
%     timez_B(5, mm) = timez_B(1, mm) + tmzl1;
%     
%     % run akron-noisy
%     %timez_B(6, mm) = timez_B(1, mm) + tmz;
%     %[x_akronnoi, x_l1n, ~, tmz] = akronoi(A, y, epsilon);
% 
%     %errs_noise(1, mm) = errs_noise(1, mm) + per_error(x, x_kron_spar);
%     errs_noise(2, mm) = errs_noise(2, mm) + per_error(x, x_cosamp);
%     errs_noise(3, mm) = errs_noise(3, mm) + per_error(x, x_omp);
%     errs_noise(4, mm) = errs_noise(4, mm) + per_error(x, x_akron);
%     %errs_noise(5, mm) = errs_noise(5, mm) + per_error(x, x_akronnoi);
%     errs_noise(6, mm) = errs_noise(6, mm) + per_error(x, x_l1);
%     %errs_noise(7, mm) = errs_noise(7, mm) + per_error(x, x_l1n);
%     
%     x_ind = find(abs(x) > DELTA);
%     %errs_noise_2(1, mm) = errs_noise_2(1, mm) + stability_error(x_ind, find(abs(x_kron_spar) > DELTA), n);
%     errs_noise_2(2, mm) = errs_noise_2(2, mm) + stability_error(x_ind, find(abs(x_cosamp) > DELTA), n);
%     errs_noise_2(3, mm) = errs_noise_2(3, mm) + stability_error(x_ind, find(abs(x_omp) > DELTA), n);
%     errs_noise_2(4, mm) = errs_noise_2(4, mm) + stability_error(x_ind, find(abs(x_akron) > DELTA), n);
%     %errs_noise_2(5, mm) = errs_noise_2(5, mm) + stability_error(x_ind, find(abs(x_akronnoi) > DELTA), n);
%     errs_noise_2(6, mm) = errs_noise_2(6, mm) + stability_error(x_ind, find(abs(x_l1) > DELTA), n);
%     %errs_noise_2(7, mm) = errs_noise_2(7, mm) + stability_error(x_ind, find(abs(x_l1n) > DELTA), n);
%     
%     
%     %errs_noise_unit(1, mm) = errs_noise_unit(1, mm) + per_error(x/norm(x), x_kron_spar/norm(x_kron_spar));
%     errs_noise_unit(2, mm) = errs_noise_unit(2, mm) + per_error(x/norm(x), x_cosamp/norm(x_cosamp));
%     errs_noise_unit(3, mm) = errs_noise_unit(3, mm) + per_error(x/norm(x), x_omp/norm(x_omp));
%     errs_noise_unit(4, mm) = errs_noise_unit(4, mm) + per_error(x/norm(x), x_akron/norm(x_akron));
%     %errs_noise_unit(5, mm) = errs_noise_unit(5, mm) + per_error(x/norm(x), x_akronnoi/norm(x_akronnoi));
%     errs_noise_unit(6, mm) = errs_noise_unit(6, mm) + per_error(x/norm(x), x_l1/norm(x_l1));
%     %errs_noise_unit(7, mm) = errs_noise_unit(7, mm) + per_error(x/norm(x), x_l1n/norm(x_l1n));
    
    mm = mm+1;
  end
  save('mat/timerz.mat');
end

% save('mat/noise_experiments.mat');

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
save('mat/timerz.mat');

