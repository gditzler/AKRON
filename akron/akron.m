function [x_kr, x_l1, n_mins, tmz, tmzl1] = akron(A, y, shift)
%  [x_kr, x_l1] = l1_approximate_reconstruction(A, y)
% 
%  INPUTS 
%  @A: measurement matrix  
%  @y: obeserved vector 
%  @shift: shift amount to find a sparser solution  
%
%  OUTPUTS
%  @x_kr: solution to the system using the l1-kr approx
%  @x_l1: solution to the system using l1
%
%  LICENSE
%    MIT
tmz = 0;
sparsity_threshold = 1e-3;
if nargin == 2 
  shift = 3;
end

X = null(A);
% s = size(X, 2); % "s=dim(ker(A))"
s = size(A, 2)-size(A,1);
n = size(A, 2);

tic;
% minimize the l1-norm
cvx_begin quiet
  variable x(n,1)
  minimize(norm(x, 1))
  subject to
    A*x == y; 
cvx_end



tmz = tmz + toc;
tmzl1 = tmz;
% save the solution to the l1 problem before approximating the kernel
% reconstruction. 
x_l1 = x;

[~, i] = sort(abs(x));

smallest = i(1:(s+shift));     % find the s+delta smallest entriries 
combrows = combnk(smallest, s);  % generate combinations of the s+delta indices

% loop over the possibilites of the s+delta entries that could be tested
% for being a `zero` entry. 
sp = zeros(size(combrows, 1), 1);
err = zeros(size(combrows, 1), 1);

tic;
parfor r = 1:size(combrows, 1)
  j = setdiff(1:n, combrows(r, :));
  xhat = A(:, j)\y;
  x_kr = zeros(n, 1);
  x_kr(j) = xhat;
  sp(r) = sum(abs(x_kr) > sparsity_threshold);  % sparisty 
  err(r) = norm(x_kr, 1);
end
[~, i] = sort(sp);

spmin = min(sp);
n_mins = sum(spmin==sp);

if spmin == 0
  sp2 = sp;
  sp2(sp2==spmin) = max(sp);
  spmin = min(sp2);
  n_mins = sum(spmin==sp2);
end

if n_mins == 1
  % solve for the sparest solution again
  j = setdiff(1:n, combrows(i(1), :));
else
  combrows2 = combrows(spmin==sp, :);
  err2 = err(spmin==sp);
  [~, jj] = min(err2);
  j = setdiff(1:n, combrows2(jj(1), :));
end
xhat = A(:, j)\y;
x_kr = zeros(n,1);
x_kr(j) = xhat;
tmz = tmz + toc;
