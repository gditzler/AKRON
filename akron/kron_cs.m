function [min_err, x_min_error, x_sparsest, min_zeros, Xsol, n_mins, tmz] = kron_cs(A, x, y)
%  [min_err, x_min_error, x_sparsest, min_zeros, Xsol] = kr(A, x, y)
% 
%  INPUTS 
%  @A: measurement matrix  
%  @x: solution vector to test (sparsest)
%  @y: obeserved vector 
%
%  OUTPUTS
%  @min_err: minimum error produced by @x_min_error
%  @x_min_error: exact solution with minimum error (cheating bc it uses `x`) 
%  @x_sparsest: exact sparsest solution 
%  @min_zeros: sparsity of the solution 
%  @Xsol: collection of (n choose s) solutions
%
%  LICENSE
%    MIT
tmz = 0;
X = null(A);
[~, n] = size(A);
s = size(X,2); % "s=dim(ker(A))"

tic;
% Compute the projection matrix in the range of "A". pinv is used here 
% because MATLAB may generate randomly A where A'*A is a singular matrix 
% Similarly we use pinv to compute Prant
Pran = A*pinv(A'*A)*A'; 

% Compute the projection matrix in the range of "A^t"
Prant = A'*pinv(A*A')*A; 

% "x0" is the particular solution in the range of "A"
xo = pinv(Pran*A*Prant)*y;
tmz = tmz + toc;

% generate the all possible "n" choose "s" combinations where 
% "dim(combrows,1)=n choose s" and "dim(combrows,2)=s"
combrows = combnk(1:n,s); 

tic;
%Ps = zeros(size(combrows,1), n, n);
Xsol = zeros(numel(x), size(combrows,1));
percent_error = zeros(size(combrows,1), 1);
%a = zeros(size(combrows,1), s);
sparsity = zeros(size(combrows,1), 1);


parfor t = 1:size(combrows,1)
  B = zeros(n, n);
  for l = 1:size(combrows,2)
    % place 1's on the pseudo diagonal of the projection matrix to keep only 
    % the "s" rows selected by the "t^th" combination
    B(combrows(t,l), combrows(t,l)) = 1;   
  end
  Xsol(:,t) = zero_out_smalls(xo + X*(-pinv(B*X)*B*xo), 1e-6); 
  percent_error(t) = per_error(Xsol(:,t), x);
  sparsity(t) = nnz(Xsol(:,t)); 
end

% our solution corresponds to the vector that minimizes the percentage error 
% \frac{\|Xsol - x\|_2}{\|x\|_2} within all possible combinations
[min_err, id] = min(percent_error);   
x_min_error = Xsol(:,id);

% the number of nonzero elements in the sparsest solution
[min_zeros, idx] = min(sparsity); 
x_sparsest = Xsol(:,idx); 

spmin = min(sparsity);
n_mins = sum(spmin==sparsity);
tmz = tmz + toc;

