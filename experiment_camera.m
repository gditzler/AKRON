clc
clear
close all

load other/camera.mat

I = camera(81:112,37:68);
n = 32;
N = n*n;
I = I/norm(I(:));
I = I - mean(I(:));
x = reshape(I,N,1);


% num obs
K = 300;

% permutation P and observation set OMEGA
P = randperm(N)';
q = randperm(N/2-1)+1;
OMEGA = q(1:K/2)';

FT = 1/sqrt(N)*fft(eye(N));
A = sqrt(2)*[real(FT(OMEGA,:)); imag(FT(OMEGA,:))];
A = [1/sqrt(N)*ones(1,N); A];
At = [];
% observations
b = A*x;
% initial point
x0 = A'*b;

parpool(20);
errors = run_cv(A, b, 5, 50, 0);
delete(gcp)
save('mat/exper_camera.mat')
