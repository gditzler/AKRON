function errors = run_cv(A, y, n_cv, k_alg, classification)

rng(1);

[n, p] = size(A);

inds = cvpartition(n, 'Kfold', n_cv);
opts.printEvery = 10000000;

errors = zeros(n_cv, 6);


if classification == 1
  calc_error = @(x,y) sum(sign(x)~=sign(y))/numel(y);
else
  calc_error = @(x,y) mean((x-y).^2);
end
for k = 1:n_cv
  itr = inds.training(k);
  ite = inds.test(k);
  
  % run cosamp
  x_cosamp = cosamp(A(itr, :), y(itr), k_alg, [], opts);
  % run omp
  x_omp = omp(A(itr, :), y(itr), k_alg, [], opts);
  % run akron 
  [x_akron, x_l1] = akron(A(itr, :), y(itr));
  % run akronoi 
  %[x_akronn, x_l1n] = akronoi(A(itr, :), y(itr), .05);
  
  % compute the output of each linear model 
  y_cosamp = A(ite, :)*x_cosamp;
  y_omp = A(ite, :)*x_omp;
  y_akron = A(ite, :)*x_akron;
  y_l1 = A(ite, :)*x_l1;
  %y_l1n = A(ite, :)*x_l1n;
  %y_akronn = A(ite, :)*x_akronn;
  
  % measure the error rates 
  errors(k, 1) = calc_error(y_cosamp, y(ite));
  errors(k, 2) = calc_error(y_omp, y(ite));
  errors(k, 3) = calc_error(y_akron, y(ite));
  errors(k, 4) = calc_error(y_l1, y(ite));
  %errors(k, 5) = calc_error(y_akronn, y(ite));
  %errors(k, 6) = calc_error(y_l1n, y(ite));
  
end

errors = nanmean(errors);


