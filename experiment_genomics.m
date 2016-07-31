clc;
clear;
close all;

addpath akron/
addpath other/

A = load('other/genomics/trainset7_112011N6Aaux.mat');
A = full(A.Aaux2);
A = A(2:end, :);
y = load('other/genomics/y.tsv');
shift = 2;

delete(gcp('nocreate'));
parpool(30);

[x_akron, x_l1, ~, tmz] = akron(A, y, shift);
delete(gcp);

save('mat/genomics.mat');



