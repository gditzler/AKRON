function [x_kr, x_l1, n_mins, tmz] = akronoi(A, y, epsilon)
%  [x_kr, x_l1] = akronoi(A, y, shift)
% 
%  INPUTS 
%  @A: measurement matrix  
%  @y: obeserved vector 
%  @epsilon: bound on the reconstruction error
%
%  OUTPUTS
%  @x_kr: solution to the system using the l1-kr approx
%  @x_l1: solution to the system using l1
%
%  LICENSE
%    MIT
tmz = 0;

sparsity_threshold = 1e-3;
X = null(A);
s = size(X, 2); % "s=dim(ker(A))"
n = size(A, 2);

tic;

% minimize the l1-norm
cvx_begin quiet
  variable x(n,1)
  minimize(norm(x, 1))
  subject to
    sum_square(A*x - y, 2) <= epsilon;
cvx_end

% save the solution to the l1 problem before approximating the kernel
% reconstruction. 
x_tmp = x;
x_l1 = x;
sgn = sign(x);

[~, i] = sort(abs(x));

smallest = i(1:s);     % find the s+delta smallest entriries 
largest = setdiff(1:n, smallest);
x_tmp = x_tmp(largest);
lgst_smallest = max(abs(x(smallest)));
sgn_largest = sign(x_tmp);

x_tmp(sgn_largest == 1) =  x_tmp(sgn_largest == 1) - lgst_smallest;
x_tmp(sgn_largest == -1) = x_tmp(sgn_largest == -1) + lgst_smallest;
x_tmp2 = zeros(n, 1);
x_tmp2(largest) = x_tmp;

sup_set = find(abs(x_tmp2) <= epsilon);
smallest = union(smallest, sup_set);


tmz = tmz + toc;


combrows = combnk(smallest, s);  % generate combinations of the s+delta indices

% loop over the possibilites of the s+delta entries that could be tested
% for being a `zero` entry. 
sp = zeros(size(combrows, 1), 1);
err = zeros(size(combrows, 1), 1);

tic;
% check if ||Ax-y||<eps is checked. 
parfor r = 1:size(combrows, 1)
  j = setdiff(1:n, combrows(r, :));

  xhat = A(:, j)\y;
  x_kr = zeros(n, 1);
  x_kr(j) = xhat;
  [~, q] = sort(abs(x_kr));
  x_kr_final = x_kr;
  
  for k = 1:n
    if norm(x_kr(q(1:k)), 2) < epsilon
      x_kr_final(q(k)) = 0;
    else
      break;
    end
  end
  
  sp(r) = sum(abs(x_kr_final) > sparsity_threshold);  % sparsity 
  err(r) = norm(x_kr, 1);
end
[~, i] = sort(sp);

spmin = min(sp);
n_mins = sum(spmin==sp);




spmin = min(sp);
n_mins = sum(spmin==sp);
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
x_kr = zeros(n, 1);
x_kr(j) = xhat;
[~, q] = sort(abs(x_kr));
x_kr_final = x_kr;
for k = 1:n
  if norm(x_kr(q(1:k)), 2) < epsilon
    x_kr_final(q(k)) = 0;
  else
    break;
  end
end
x_kr = x_kr_final;
tmz = tmz + toc;

