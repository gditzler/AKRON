%%
% SIMPLE_EXAMPLE
%
% Run AKRON and L1 on a simple example to show the benefit of using
% delta-neighborhoods to search for a sparse solution that simply using L1.
%
% Contributors 
% Gregory Ditzler, Nidhal Bouaynaya, Roman Shterenberg 
clc;
clear
close all;

addpath('akron/');

% set up the simple linear system
A = [[-.4588,1.5977,-.8724,-.1121,-1.3068];
     [.2942,3.0954,-1.053,.3454,1.527];
     [-.1948,-.7558,-.9756,.1549,.9586]]; % measurement matrix
x = [0;0;0;-1.2372;1.04858]; % optimal solution 
y = A*x;     % output: no noise 
delta = 1;   % choose a 1-neighborhood

% run AKRON 
[x_kr, x_l1] = akron(A, y, delta);

disp('Reconstuction Error: ');
disp(['L1:    ', num2str(norm(x-x_l1)/norm(x))]);
disp(['AKRON: ', num2str(norm(x-x_kr)/norm(x))]);

%%
% SIMPLE_EXAMPLE
%
% Run AKRON and L1 on a simple example to show the benefit of using
% delta-neighborhoods to search for a sparse solution that simply using L1.
%
% Contributors 
% Gregory Ditzler, Nidhal Bouaynaya, Roman Shterenberg 
clc;
clear
close all;

addpath('akron/');
s = 0.75;
shift = 2;

% set up the simple linear system
A = [[-.4588,1.5977,-.8724,-.1121,-1.3068];
     [.2942,3.0954,-1.053,.3454,1.527];
     [-.1948,-.7558,-.9756,.1549,.9586]]; % measurement matrix
x = [0;0;0;-1.2372;1.04858]; % optimal solution 

e = [-0.021, 0.034, 0.0567]'/2; 
y = A*x + e;
epsilon = norm(e);

% run AKRON 
[x_kr, x_l1] = akron(A, y, shift, epsilon);
[x_krn, x_l1n] = akronoi(A, y, epsilon);
[x_krn2, x_l1n2] = akronoi2(A, y, epsilon, shift);

