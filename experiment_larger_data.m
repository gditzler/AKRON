% EXPERIMENT_LARGER_DATA
% 
% Run AKRON, L1, OMP and CoSaMP on on the Gaussian data set with an
% increasing number of variables in the data. KRON is left out of the
% comparision for computational limitations. 
% 
% Contributors 
% Gregory Ditzler, Nidhal Bouaynaya, Roman Shterenberg 
clc;
clear;
close all;

set(0,'RecursionLimit', 10000);

addpath('akron/');
addpath('other/');

n_avg = 100;              % number of averages to run
n_set = 50:25:250;        % "p" in the paper: # of variables 
k_set = floor(.05*n_set); % sparest solution 
mp = .1;                  % percentage of "p" to determine "m"
k_alg_set = floor(.1*n_set);  % percentage of "p" to determine "k" for OMP/CoSaMP
types = 'Gaussian';       % genenate Gaussian data 
opts.printEvery = 10000000;
errFcn = [];              % OMP/CoSaMP error function 
DELTA = 1e-3;

% start the parallel pool - you'll need a large cluster for this
delete(gcp('nocreate'));
parpool(50);

errs = zeros(4, length(n_set));
stabilities = zeros(4, length(n_set));
errs_no_norm = zeros(4, length(n_set));
timez = zeros(4, length(n_set));
sparsity = zeros(4, length(n_set));

for i = 1:n_avg
  disp(['Running trial ',num2str(i), ' of ', num2str(n_avg)]);

  for j = 1:length(n_set)
    q = 1;
    
    % set all of the parameters for this version of n_set
    k_alg_set = floor(.1*n_set);
    n = n_set(j);
    k = ceil(0.05*n);
    k_alg = k_alg_set(j);
    m = ceil(mp*n);

    % generate the system and find the indices of the non-zero elements 
    [A, x, y] = cs_model(m, n, k, types);
    x_ind = find(abs(x) > DELTA);

    % CoSamp
    disp('CoSaMP')
    tic;
    x_hat = cosamp(A, y, k_alg, errFcn, opts);
    timez(q, j) = timez(q, j) + toc;
    errs(q, j) = errs(q, j) + per_error(x/norm(x), x_hat/norm(x_hat));
    stabilities(q, j) = stabilities(q, j) + stability_error(x_ind, find(abs(x_hat)>DELTA), n);
    errs_no_norm(q, j) = errs_no_norm(q, j) + per_error(x, x_hat);
    sparsity(q, j) = sparsity(q, j) + sum(abs(x_hat) >= DELTA)/numel(x);
    q = q+1;

    % OMP
    disp('OMP')
    tic;
    x_omp = omp(A, y, k_alg, errFcn, opts);
    timez(q, j) = timez(q, j) + toc;
    errs(q, j) = errs(q, j) + per_error(x/norm(x), x_omp/norm(x_omp));
    stabilities(q, j) = stabilities(q, j) + stability_error(x_ind, find(abs(x_omp)>DELTA), n);
    errs_no_norm(q, j) = errs_no_norm(q, j) + per_error(x, x_omp);
    sparsity(q, j) = sparsity(q, j) + sum(abs(x_omp) >= DELTA)/numel(x);
    q = q+1;

    % AKRON and L1
    disp('AKRON')
    %tic;
    [x_l1kr, x_l1, ~, tmp] = akron(A, y);
    timez(q, j) = timez(q, j) + tmp;
    %timez(q, j) = timez(q, j) + toc;
    errs(q, j) = errs(q, j) + per_error(x/norm(x), x_l1kr/norm(x_l1kr));
    stabilities(q, j) = stabilities(q, j) + stability_error(x_ind, find(abs(x_l1kr)>DELTA), n);
    errs_no_norm(q, j) = errs_no_norm(q, j) + per_error(x, x_l1kr);
    sparsity(q, j) = sparsity(q, j) + sum(abs(x_l1kr) >= DELTA)/numel(x);
    q = q+1;

    errs(q, j) = errs(q, j) + per_error(x/norm(x), x_l1/norm(x_l1));
    stabilities(q, j) = stabilities(q, j) + stability_error(x_ind, find(abs(x_l1)>DELTA), n);
    errs_no_norm(q, j) = errs_no_norm(q, j) + per_error(x, x_l1);
    sparsity(q, j) = sparsity(q, j) + sum(abs(x_l1) >= DELTA)/numel(x);
    q = q+1;

  end
  % save data on each average just to be safe 
 save(['mat/large_',types,'_mp',num2str(mp*100),'_noise.mat']); 
end

errs = errs/n_avg;
errs_no_norm = errs_no_norm/n_avg;
stabilities = stabilities/n_avg;
sparsity = sparsity/n_avg;
timez = timez/n_avg;

save(['mat/large_',types,'_mp',num2str(mp*100),'_noise.mat']); 

delete(gcp('nocreate'));
