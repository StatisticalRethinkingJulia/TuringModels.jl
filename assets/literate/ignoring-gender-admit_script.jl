# This file was generated, do not modify it.

import CSV
import Random

using DataFrames
using Turing
using TuringModels

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "UCBadmit.csv")
df = CSV.read(data_path, DataFrame; delim=';')

dept_map = Dict(key => idx for (idx, key) in enumerate(unique(df.dept)))
df.male = [g == "male" ? 1 : 0 for g in df.gender]
df.dept_id = [dept_map[de] for de in df.dept]
df

@model function m13_4(applications, dept_id, male, admit)
    sigma_dept ~ truncated(Cauchy(0, 2), 0, Inf)
    a ~ Normal(0, 10)
    a_dept ~ filldist(Normal(a, sigma_dept), 6)

    logit_p = a_dept[dept_id]

    admit .~ BinomialLogit.(applications, logit_p)
end;

chns = sample(
    m13_4(df.applications, df.dept_id, df.male, df.admit),
    Turing.NUTS(),
    5000
)

m_13_4_rethinking = """
Inference for Stan model: 0c5c36512c20c41995d1bd25be525138.
    3 chains, each with iter=4500; warmup=500; thin=1;
    post-warmup draws per chain=4000, total post-warmup draws=12000.

                   mean se_mean   sd     2.5%      25%      50%      75%    97.5%
    a_dept[1]      0.59    0.00 0.07     0.46     0.54     0.59     0.64     0.73
    a_dept[2]      0.54    0.00 0.09     0.37     0.48     0.54     0.60     0.71
    a_dept[3]     -0.62    0.00 0.07    -0.75    -0.66    -0.62    -0.57    -0.49
    a_dept[4]     -0.67    0.00 0.08    -0.81    -0.72    -0.67    -0.62    -0.52
    a_dept[5]     -1.09    0.00 0.10    -1.28    -1.15    -1.09    -1.03    -0.90
    a_dept[6]     -2.65    0.00 0.15    -2.96    -2.75    -2.65    -2.55    -2.37
    a             -0.63    0.01 0.63    -1.89    -1.01    -0.64    -0.26     0.66
    sigma_dept     1.45    0.01 0.57     0.77     1.08     1.33     1.68     2.90
    lp__       -2602.37    0.03 2.08 -2607.45 -2603.49 -2602.01 -2600.86 -2599.35
               n_eff Rhat
    a_dept[1]  11285    1
    a_dept[2]  11943    1
    a_dept[3]  12707    1
    a_dept[4]  11592    1
    a_dept[5]  14598    1
    a_dept[6]  13363    1
    a           6965    1
    sigma_dept  5643    1
    lp__        5322    1
""";

