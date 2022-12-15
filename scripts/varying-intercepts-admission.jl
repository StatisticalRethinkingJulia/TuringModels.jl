# ## Data

import CSV
import Random
import TuringModels

using DataFrames

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "UCBadmit.csv")
df = CSV.read(data_path, DataFrame; delim=';')

dept_map = Dict(key => idx for (idx, key) in enumerate(unique(df.dept)))
df.male = [g == "male" ? 1 : 0 for g in df.gender]
df.dept_id = [dept_map[de] for de in df.dept]
df

# ## Model

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

# ## Output

chns = sample(
    m13_3(df.applications, df.dept_id, df.male, df.admit),
    NUTS(0.95),
    1000
)

# \defaultoutput{}

# ## Original output

m_13_3_rethinking = """
Inference for Stan model: f0d86ec689cbf7921aab4fc0f55616d2.
    4 chains, each with iter=5000; warmup=1000; thin=1; 
    post-warmup draws per chain=4000, total post-warmup draws=16000.
    
                      mean se_mean   sd     2.5%      25%      50%      75%
    bm_dept[1]       -0.79    0.00 0.27    -1.32    -0.97    -0.79    -0.61
    bm_dept[2]       -0.21    0.00 0.33    -0.87    -0.42    -0.20     0.00
    bm_dept[3]        0.08    0.00 0.14    -0.18    -0.01     0.08     0.18
    bm_dept[4]       -0.09    0.00 0.14    -0.37    -0.19    -0.09     0.00
    bm_dept[5]        0.12    0.00 0.19    -0.24    -0.01     0.12     0.25
    bm_dept[6]       -0.12    0.00 0.27    -0.67    -0.29    -0.12     0.05
    a_dept[1]         1.30    0.00 0.25     0.82     1.13     1.30     1.47
    a_dept[2]         0.74    0.00 0.33     0.08     0.52     0.73     0.95
    a_dept[3]        -0.65    0.00 0.09    -0.82    -0.71    -0.65    -0.59
    a_dept[4]        -0.62    0.00 0.10    -0.83    -0.69    -0.62    -0.55
    a_dept[5]        -1.13    0.00 0.11    -1.36    -1.21    -1.13    -1.05
    a_dept[6]        -2.60    0.00 0.20    -3.01    -2.73    -2.60    -2.46
    a                -0.49    0.01 0.73    -1.96    -0.91    -0.49    -0.07
    bm               -0.16    0.00 0.24    -0.65    -0.29    -0.16    -0.02
    sigma_dept[1]     1.67    0.01 0.63     0.88     1.25     1.53     1.94
    sigma_dept[2]     0.50    0.00 0.26     0.16     0.33     0.45     0.61
    Rho[1,1]          1.00     NaN 0.00     1.00     1.00     1.00     1.00
    Rho[1,2]         -0.31    0.00 0.35    -0.87    -0.59    -0.35    -0.08
    Rho[2,1]         -0.31    0.00 0.35    -0.87    -0.59    -0.35    -0.08
    Rho[2,2]          1.00    0.00 0.00     1.00     1.00     1.00     1.00
    lp__          -2593.92    0.04 3.17 -2601.03 -2595.85 -2593.57 -2591.65
                     97.5% n_eff Rhat
    bm_dept[1]       -0.27  6918    1
    bm_dept[2]        0.46  9133    1
    bm_dept[3]        0.36 13016    1
    bm_dept[4]        0.19 12258    1
    bm_dept[5]        0.49 12953    1
    bm_dept[6]        0.40 12011    1
    a_dept[1]         1.81  6993    1
    a_dept[2]         1.39  9335    1
    a_dept[3]        -0.48 13489    1
    a_dept[4]        -0.42 12595    1
    a_dept[5]        -0.91 14659    1
    a_dept[6]        -2.23 13168    1
    a                 0.96  9541    1
    bm                0.31  8946    1
    sigma_dept[1]     3.27  9058    1
    sigma_dept[2]     1.15  6626    1
    Rho[1,1]          1.00   NaN  NaN
    Rho[1,2]          0.44 11358    1
    Rho[2,1]          0.44 11358    1
    Rho[2,2]          1.00 16069    1
    lp__          -2588.70  5310    1    
""";
