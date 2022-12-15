# This file was generated, do not modify it. # hide
@model function m13_4(applications, dept_id, male, admit)
    sigma_dept ~ truncated(Cauchy(0, 2), 0, Inf)
    a ~ Normal(0, 10)
    a_dept ~ filldist(Normal(a, sigma_dept), 6)

    logit_p = a_dept[dept_id]

    admit .~ BinomialLogit.(applications, logit_p)
end;