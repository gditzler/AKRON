clc;
clear
close all;

addpath('akron/');

A = [[-.4588,1.5977,-.8724,-.1121,-1.3068];
     [.2942,3.0954,-1.053,.3454,1.527];
     [-.1948,-.7558,-.9756,.1549,.9586]];
x = [0;0;0;-1.2372;1.04858];
y = A*x;
shift = 1;

[x_kr, x_l1] = akron(A, y, shift);

disp(['L1:    ', num2str(norm(x-x_l1)/norm(x))])
disp(['AKRON: ', num2str(norm(x-x_kr)/norm(x))])