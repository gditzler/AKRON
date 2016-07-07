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
data = load('~/Git/ClassificationDatasets/csv/spectf_train_test.csv'); 
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);

%% molec-biol-promoter_test
data = load('~/Git/ClassificationDatasets/csv/molec-biol-promoter_test.csv'); 
k_alg = 5;
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);
%% conn-bench-sonar-mines-rocks_test
data = load('~/Git/ClassificationDatasets/csv/conn-bench-sonar-mines-rocks_test.csv'); 
k_alg = 5;
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);
%% breast-cancer-wisc-prog_test
data = load('~/Git/ClassificationDatasets/csv/breast-cancer-wisc-prog_test.csv'); 
k_alg = 5;
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);
%% echocardiogram_test
data = load('~/Git/ClassificationDatasets/csv/echocardiogram_test.csv'); 
k_alg = 5;
A = data(:, 1:end-1);
y = data(:, end);
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);
%% echocardiogram_test
A=load('~/Downloads/ARCENE/ARCENE/arcene_train.data');
y=load('~/Downloads/ARCENE/ARCENE/arcene_train.labels');

stdX = std(A);                            %stdX = standard deviation of X
idx1 = stdX~=0;                           %idx1 persists where the std X is not zero
centrX = A-repmat(mean(A),size(A,1),1);   %Subtracts a tiling from X
A(:,idx1) = centrX(:,idx1)./repmat(stdX(:,idx1),size(A,1),1); %$X at the specified indices = centrX at the same indices, divided by a tiled matrix of the standard deviation at the specified indices

A = (A-repmat(mean(A),size(A,1),1));%./repmat(std(A),size(A,1),1); %Overwrite X as current X-tiled mean
A = A./repmat(sqrt(sum(A.*A,2)),1, size(A,2));    %Overwrite X as x X divided by tiled sqrt(sum of X.*X,2)


k_alg = floor(.05*size(A,2));
y(y==0) = -1;
errors(end+1, :) = run_cv(A, y, n_cv, k_alg, classification);

%%
errors(isnan(errors)) = 100;
[hZtest, pZtest, pFtest] = friedman_demsar(errors, 'two', .1)
ranks = rank_rows(errors);