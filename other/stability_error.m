function err = stability_error(Aopt, Aest, p)
% err = numel(intersect(Aopt, Aest))/(p-numel(Aopt));
err = numel(intersect(Aopt, Aest))/numel(union(Aopt, Aest));
