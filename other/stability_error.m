function err = stability_error(Aopt, Aest, p)
err = numel(intersect(Aopt, Aest))/(p-numel(Aopt));

