<!--This file was generated, do not modify it.-->
## Data

```julia:ex1
import CSV
import Random
import TuringModels

using DataFrames
using RData
using LinearAlgebra

Random.seed!(1)

data_dir = joinpath(TuringModels.project_root, "data")
kline_path = joinpath(data_dir, "Kline2.csv")
df = CSV.read(kline_path, DataFrame; delim=';')

dmat_path = joinpath(data_dir, "islandsDistMatrix.rda")
dmat = load(dmat_path)["islandsDistMatrix"]

df.society = 1:10;
df
```

## Model

```julia:ex2
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
```

## Output

\defaultoutput{}

## Original output

```julia:ex3
m_13_7_rethinking = """
Inference for Stan model: 6422d8042e9cdd08dae2420ad26842f1.
    4 chains, each with iter=10000; warmup=2000; thin=1;
    post-warmup draws per chain=8000, total post-warmup draws=32000.

            mean se_mean    sd   2.5%    25%    50%    75%  97.5% n_eff Rhat
    g[1]   -0.27    0.01  0.44  -1.26  -0.50  -0.24  -0.01   0.53  3278    1
    g[2]   -0.13    0.01  0.43  -1.07  -0.34  -0.10   0.12   0.67  3144    1
    g[3]   -0.17    0.01  0.42  -1.10  -0.37  -0.14   0.07   0.59  3096    1
    g[4]    0.30    0.01  0.37  -0.51   0.12   0.30   0.50   1.02  3145    1
    g[5]    0.03    0.01  0.37  -0.77  -0.15   0.04   0.22   0.72  3055    1
    g[6]   -0.46    0.01  0.38  -1.31  -0.64  -0.42  -0.23   0.19  3306    1
    g[7]    0.10    0.01  0.36  -0.70  -0.07   0.11   0.29   0.78  3175    1
    g[8]   -0.26    0.01  0.37  -1.07  -0.43  -0.24  -0.06   0.40  3246    1
    g[9]    0.23    0.01  0.35  -0.52   0.07   0.25   0.42   0.89  3302    1
    g[10]  -0.12    0.01  0.45  -1.04  -0.36  -0.11   0.13   0.77  5359    1
    a       1.31    0.02  1.15  -0.98   0.61   1.31   2.00   3.69  4389    1
    bp      0.25    0.00  0.11   0.02   0.18   0.24   0.31   0.47  5634    1
    etasq   0.34    0.01  0.53   0.03   0.10   0.20   0.39   1.52  5643    1
    rhosq   1.52    0.09 11.82   0.03   0.16   0.39   0.96   7.96 15955    1
    lp__  925.98    0.03  2.96 919.16 924.20 926.34 928.14 930.67  7296    1
""";
```

