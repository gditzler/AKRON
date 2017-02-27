clc;
clear;
close all;

rng(1);

addpath('akron/');
addpath('other/');

n_avg = 100;
n = 200;
k = floor(.05*n);
Ms = floor([.05 .1 .15 .2 .25 .3 .35]*n);
M = length(Ms);
k_alg = 15;
epsilon = 0.05;
timez_A = zeros(5, M);

delete(gcp('nocreate'));
parpool(90);

opts.printEvery = 10000000;
errFcn = [];

for i = 1:n_avg
  disp(['Running trial ',num2str(i), ' of ', num2str(n_avg)]);

  mm = 1;
  for m = Ms
    
    % generate data from the Gaussian CS model 
    [A, x, y] = cs_model(m, n, k, 'Gaussian');
    
    % run cosamp
    tic; 
    x_cosamp = cosamp(A, y, k_alg, errFcn, opts);
    timez_A(1, mm) = timez_A(1, mm) + toc;
    
    % run omp
    tic; 
    x_omp = omp(A, y, k_alg, errFcn, opts);
    timez_A(2, mm) = timez_A(2, mm) + toc;
    
    % run akron 
    [x_akron, x_l1, ~, tmz, tmzl1] = akron(A, y);
    timez_A(3, mm) = timez_A(3, mm) + tmz;
    timez_A(4, mm) = timez_A(4, mm) + tmzl1;
    tic; 
    
    x_hat = SL0(A, y, 0.00001);
    timez_A(5, mm) = timez_A(5, mm) + toc;
        
    mm = mm+1;
  end
  save('mat/timerz_fix_p.mat');
end

timez_A = timez_A/n_avg;

save('mat/timerz_fix_p.mat');

