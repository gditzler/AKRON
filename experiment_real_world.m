clc
clear
close all

addpath akron/
addpath other/

n_cv = 5;
k_alg = 7;
base_path = '/scratch/ditzler/Git/ClassificationDatasets/csv/';
dsets = {'echocardiogram_test.csv'
  'breast-cancer-wisc-prog_test.csv'
  'conn-bench-sonar-mines-rocks_test.csv'
  'spectf_train_test.csv'
  'csv/trains.csv'
  'musk-1_test.csv'};
errors = zeros(length(dsets), 6);
classification = 1;

delete(gcp('nocreate'));
parpool(25);
for n = 1:length(dsets)
  try 
    data = load([base_path, dsets{n}]); 
    A = data(:, 1:end-1);
    y = data(:, end);
    y(y==0) = -1;
    errors(n, :) = run_cv(A, y, n_cv, k_alg, classification);
  catch 
    disp(['Error on ', dsets{n}]);
  end
end

delete(gcp);

errors(isnan(errors)) = 1;
errors = errors(:, 1:4);
[hZtest, pZtest, pFtest] = friedman_demsar(errors, 'left', .1);
ranks = rank_rows(errors);
save('mat/real_world.mat');
