# This file was generated, do not modify it. # hide
using Turing

dept_map = Dict(key => idx for (idx, key) in enumerate(unique(df.dept)))
df.male = [g == "male" ? 1 : 0 for g in df.gender]
df.dept_id = [dept_map[de] for de in df.dept]

@model m13_2(applications, dept_id, male, admit) = begin
    sigma_dept ~ truncated(Cauchy(0, 2), 0, Inf)
    bm ~ Normal(0, 1)
    a ~ Normal(0, 10)
    a_dept ~ filldist(Normal(a, sigma_dept), 6)

    logit_p = a_dept[dept_id] + bm*male

    admit .~ BinomialLogit.(applications, logit_p)
end

chns = sample(
    m13_2(df.applications, df.dept_id, df.male, df.admit),
    NUTS(),
    1000
)