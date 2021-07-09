<!--This file was generated, do not modify it.-->
## Data

```julia:ex1
import CSV
import Random
import TuringModels

using DataFrames

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "UCBadmit.csv")
df = CSV.read(data_path, DataFrame; delim=';')
```

## Model

```julia:ex2
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
```

## Output

\defaultoutput{}

## Original output

```julia:ex3
"""
Inference for Stan model: 359c2483e3bdbf74fd0484be27c2909b.
    3 chains, each with iter=4500; warmup=500; thin=1;
    post-warmup draws per chain=4000, total post-warmup draws=12000.

                   mean se_mean   sd     2.5%      25%      50%      75%    97.5%
    a_dept[1]      0.67    0.00 0.10     0.48     0.61     0.67     0.74     0.87
    a_dept[2]      0.63    0.00 0.12     0.40     0.55     0.63     0.71     0.85
    a_dept[3]     -0.58    0.00 0.08    -0.73    -0.63    -0.58    -0.53    -0.44
    a_dept[4]     -0.62    0.00 0.09    -0.79    -0.67    -0.62    -0.56    -0.45
    a_dept[5]     -1.06    0.00 0.10    -1.26    -1.13    -1.06    -0.99    -0.86
    a_dept[6]     -2.61    0.00 0.16    -2.92    -2.71    -2.60    -2.50    -2.31
    a             -0.59    0.01 0.66    -1.94    -0.97    -0.59    -0.21     0.73
    bm            -0.09    0.00 0.08    -0.25    -0.15    -0.09    -0.04     0.06
    sigma_dept     1.49    0.01 0.62     0.78     1.09     1.35     1.71     3.01
    lp__       -2602.27    0.04 2.27 -2607.74 -2603.48 -2601.90 -2600.61 -2598.95
               n_eff Rhat
    a_dept[1]   8191    1
    a_dept[2]   8282    1
    a_dept[3]  10974    1
    a_dept[4]  10034    1
    a_dept[5]  10783    1
    a_dept[6]  10344    1
    a           5839    1
    bm          7137    1
    sigma_dept  4626    1
    lp__        4200    1
""";
```

