clc
clear
close all

addpath akron/
addpath other/

n_cv = 10;
k_alg = 15;

[A, x, y] = cs_model(200, 250, 8, 'Gaussian');
errors =[];
classification = 1;
%% spectf_train_test
data = load('/scratch/ditzler/Git/ClassificationDatasets/csv/spectf_train_test.csv'); 
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);

%% molec-biol-promoter_test
data = load('/scratch/ditzler/Git/ClassificationDatasets/csv/molec-biol-promoter_test.csv'); 
k_alg = 5;
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);
%% conn-bench-sonar-mines-rocks_test
data = load('/scratch/ditzler/Git/ClassificationDatasets/csv/conn-bench-sonar-mines-rocks_test.csv'); 
k_alg = 5;
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);
%% breast-cancer-wisc-prog_test
data = load('/scratch/ditzler/Git/ClassificationDatasets/csv/breast-cancer-wisc-prog_test.csv'); 
k_alg = 5;
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);
%% echocardiogram_test
data = load('/scratch/ditzler/Git/ClassificationDatasets/csv/echocardiogram_test.csv'); 
k_alg = 5;
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);

%%
errors(isnan(errors)) = 100;
[hZtest, pZtest, pFtest] = friedman_demsar(errors, 'two', .1)
ranks = rank_rows(errors);
save('mat/real_world.mat');
