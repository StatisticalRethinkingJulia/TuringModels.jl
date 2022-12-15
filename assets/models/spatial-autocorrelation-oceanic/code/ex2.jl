# This file was generated, do not modify it. # hide
using Turing

@model function m13_7(Dmat, society, logpop, total_tools)
    rhosq ~ truncated(Cauchy(0, 1), 0, Inf)
    etasq ~ truncated(Cauchy(0, 1), 0, Inf)
    bp ~ Normal(0, 1)
    a ~ Normal(0, 10)

    # GPL2
    SIGMA_Dmat = etasq * exp.(-rhosq * Dmat.^2)
    SIGMA_Dmat = SIGMA_Dmat + 0.01I
    SIGMA_Dmat = (SIGMA_Dmat' + SIGMA_Dmat) / 2
    g ~ MvNormal(zeros(10), SIGMA_Dmat)

    log_lambda = a .+ g[society] .+ bp * logpop

    total_tools .~ Poisson.(exp.(log_lambda))
end

chns = sample(
    m13_7(dmat, df.society, df.logpop, df.total_tools),
    NUTS(),
    5000
)