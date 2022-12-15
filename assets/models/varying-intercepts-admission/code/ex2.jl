# This file was generated, do not modify it. # hide
using Turing

@model function m13_3(applications, dept_id, male, admit)
    Rho ~ LKJ(2, 2.)
    sigma_dept ~ filldist(truncated(Cauchy(0, 2), 0, Inf), 2)
    bm ~ Normal(0, 1)
    a ~ Normal(0, 1)

    dist_mu = [a, bm]
    dist_Sigma = sigma_dept .* Rho .* sigma_dept'
    dist_Sigma = (dist_Sigma' + dist_Sigma) / 2

    a_bm_dept ~ filldist(MvNormal(dist_mu, dist_Sigma), 6)

    a_dept, bm_dept = a_bm_dept[1, :], a_bm_dept[2, :]
    logit_p = a_dept[dept_id] + bm_dept[dept_id] .* male

    admit .~ BinomialLogit.(applications, logit_p)
end;