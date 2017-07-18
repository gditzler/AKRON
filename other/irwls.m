function x = irwls(A, b, max_iter, epsilon)
% https://web.stanford.edu/~boyd/papers/pdf/rwl1.pdf
[~, p] = size(A);
w = ones(p, 1);
w_old = w;

for i = 1:max_iter
  
  W = diag(w);
  
  cvx_begin quiet
    variable xhat(p,1)
    minimize(norm(W*xhat, 1))
    subject to
      A*xhat == b;
  cvx_end
  
  w = 1./(epsilon + abs(xhat));
  if norm(w-w_old, 2) < 1e-6
    break
  end
  w_old = w;
end
x = xhat;
x(abs(x)<1e-3) = 0;