# ## Data

import CSV
import Random
import TuringModels

using DataFrames

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "chimpanzees.csv")
df = CSV.read(data_path, DataFrame; delim=';')

df.block_id = df.block

# ## Model

using Turing

@model m13_6(actor, block_id, condition, prosoc_left, pulled_left) = begin
    ## fixed priors
    Rho_block ~ LKJ(3, 4.)
    Rho_actor ~ LKJ(3, 4.)
    sigma_block ~ filldist(truncated(Cauchy(0, 2), 0, Inf), 3)
    sigma_actor ~ filldist(truncated(Cauchy(0, 2), 0, Inf), 3)
    a ~ Normal(0, 1)
    bp ~ Normal(0, 1)
    bpc ~ Normal(0, 1)
    
    ## adaptive priors
    Sigma_block = sigma_block .* Rho_block .* sigma_block'
    Sigma_block = (Sigma_block' + Sigma_block) / 2
    Sigma_actor = sigma_actor .* Rho_actor .* sigma_actor'
    Sigma_actor = (Sigma_actor' + Sigma_actor) / 2
    
    a_block_bp_block_bpc_block ~ filldist(MvNormal(zeros(3), Sigma_block), 6)
    a_actor_bp_actor_bpc_actor ~ filldist(MvNormal(zeros(3), Sigma_actor), 7)
    
    a_block = a_block_bp_block_bpc_block[1, :]
    bp_block = a_block_bp_block_bpc_block[2, :]
    bpc_block = a_block_bp_block_bpc_block[3, :]
    a_actor = a_actor_bp_actor_bpc_actor[1, :]
    bp_actor = a_actor_bp_actor_bpc_actor[2, :]
    bpc_actor = a_actor_bp_actor_bpc_actor[3, :]
    
    ## linear models
    BPC = bpc .+ bpc_actor[actor] + bpc_block[block_id]
    BP = bp .+ bp_actor[actor] + bp_block[block_id]
    A = a .+ a_actor[actor] + a_block[block_id]
    logit_p = A + (BP + BPC .* condition) .* prosoc_left
    
    ## likelihood
    pulled_left .~ BinomialLogit.(1, logit_p)
end

# ## Output

chns = sample(
    m13_6(df.actor, df.block_id, df.condition, df.prosoc_left, df.pulled_left),
    NUTS(0.95),
    1000
)

# \defaultoutput{}

# ## Original output

m_13_6_rethinking = """
Inference for Stan model: cdd1241666414818ec292db21291c409.
    3 chains, each with iter=5000; warmup=1000; thin=1; 
    post-warmup draws per chain=4000, total post-warmup draws=12000.
    
                      mean se_mean    sd    2.5%     25%     50%     75%   97.5%
    bpc_actor[1]      0.02    0.01  0.41   -0.89   -0.16    0.01    0.20    0.91
    bpc_actor[2]      0.17    0.01  0.77   -1.20   -0.15    0.04    0.40    2.10
    bpc_actor[3]     -0.28    0.01  0.48   -1.53   -0.49   -0.15    0.02    0.43
    bpc_actor[4]     -0.05    0.01  0.43   -1.06   -0.22   -0.02    0.14    0.79
    bpc_actor[5]     -0.07    0.01  0.43   -1.05   -0.25   -0.03    0.12    0.75
    bpc_actor[6]     -0.12    0.01  0.44   -1.19   -0.30   -0.05    0.10    0.69
    bpc_actor[7]      0.40    0.02  0.70   -0.42    0.00    0.18    0.63    2.18
    bp_actor[1]       0.07    0.01  0.38   -0.67   -0.12    0.03    0.25    0.93
    bp_actor[2]       0.03    0.02  0.69   -1.22   -0.26   -0.01    0.26    1.54
    bp_actor[3]       0.24    0.01  0.42   -0.42   -0.02    0.14    0.44    1.29
    bp_actor[4]       0.17    0.01  0.40   -0.55   -0.05    0.09    0.36    1.11
    bp_actor[5]       0.10    0.01  0.38   -0.66   -0.09    0.05    0.28    0.99
    bp_actor[6]      -0.32    0.01  0.43   -1.38   -0.56   -0.22   -0.02    0.30
    bp_actor[7]      -0.04    0.01  0.45   -1.02   -0.24   -0.01    0.17    0.88
    a_actor[1]       -1.04    0.02  0.69   -2.41   -1.50   -1.04   -0.58    0.30
    a_actor[2]        4.37    0.03  1.54    2.13    3.32    4.13    5.13    8.02
    a_actor[3]       -1.33    0.02  0.70   -2.70   -1.79   -1.32   -0.85    0.00
    a_actor[4]       -1.37    0.02  0.69   -2.75   -1.82   -1.35   -0.90   -0.04
    a_actor[5]       -1.02    0.02  0.69   -2.38   -1.48   -1.01   -0.55    0.31
    a_actor[6]        0.18    0.02  0.69   -1.15   -0.29    0.18    0.62    1.54
    a_actor[7]        1.53    0.02  0.73    0.14    1.04    1.52    2.01    3.01
    bpc_block[1]     -0.39    0.01  0.54   -1.69   -0.67   -0.25   -0.01    0.36
    bpc_block[2]      0.19    0.01  0.45   -0.57   -0.05    0.10    0.40    1.28
    bpc_block[3]      0.23    0.01  0.47   -0.52   -0.04    0.14    0.45    1.39
    bpc_block[4]     -0.08    0.01  0.46   -1.14   -0.28   -0.04    0.13    0.83
    bpc_block[5]     -0.08    0.01  0.42   -1.05   -0.28   -0.04    0.13    0.74
    bpc_block[6]      0.09    0.01  0.47   -0.86   -0.14    0.04    0.32    1.18
    bp_block[1]      -0.18    0.01  0.44   -1.14   -0.42   -0.13    0.06    0.70
    bp_block[2]      -0.12    0.01  0.42   -1.07   -0.33   -0.07    0.11    0.69
    bp_block[3]      -0.24    0.01  0.45   -1.27   -0.48   -0.17    0.02    0.52
    bp_block[4]       0.16    0.01  0.43   -0.62   -0.08    0.10    0.37    1.15
    bp_block[5]       0.04    0.01  0.41   -0.78   -0.19    0.02    0.25    0.96
    bp_block[6]       0.64    0.02  0.57   -0.14    0.19    0.55    0.98    1.97
    a_block[1]       -0.12    0.01  0.24   -0.71   -0.23   -0.07    0.01    0.24
    a_block[2]        0.06    0.00  0.22   -0.33   -0.04    0.03    0.16    0.61
    a_block[3]        0.10    0.01  0.24   -0.27   -0.02    0.05    0.20    0.69
    a_block[4]        0.00    0.00  0.20   -0.46   -0.09    0.00    0.09    0.42
    a_block[5]       -0.02    0.00  0.21   -0.50   -0.11   -0.01    0.07    0.40
    a_block[6]        0.00    0.00  0.22   -0.48   -0.09    0.00    0.10    0.46
    a                 0.26    0.02  0.63   -0.97   -0.16    0.26    0.69    1.50
    bp                0.71    0.01  0.41   -0.14    0.46    0.73    0.97    1.48
    bpc              -0.03    0.01  0.43   -0.85   -0.31   -0.04    0.22    0.87
    sigma_actor[1]    2.31    0.01  0.88    1.18    1.72    2.14    2.69    4.52
    sigma_actor[2]    0.48    0.01  0.37    0.03    0.21    0.40    0.65    1.36
    sigma_actor[3]    0.51    0.01  0.45    0.03    0.19    0.40    0.71    1.69
    sigma_block[1]    0.24    0.01  0.21    0.01    0.09    0.19    0.33    0.77
    sigma_block[2]    0.59    0.01  0.41    0.04    0.30    0.51    0.79    1.58
    sigma_block[3]    0.53    0.01  0.41    0.03    0.23    0.44    0.73    1.55
    Rho_actor[1,1]    1.00     NaN  0.00    1.00    1.00    1.00    1.00    1.00
    Rho_actor[1,2]   -0.07    0.01  0.32   -0.66   -0.30   -0.07    0.16    0.54
    Rho_actor[1,3]    0.08    0.01  0.32   -0.56   -0.15    0.09    0.32    0.67
    Rho_actor[2,1]   -0.07    0.01  0.32   -0.66   -0.30   -0.07    0.16    0.54
    Rho_actor[2,2]    1.00    0.00  0.00    1.00    1.00    1.00    1.00    1.00
    Rho_actor[2,3]   -0.06    0.00  0.31   -0.64   -0.29   -0.06    0.17    0.56
    Rho_actor[3,1]    0.08    0.01  0.32   -0.56   -0.15    0.09    0.32    0.67
    Rho_actor[3,2]   -0.06    0.00  0.31   -0.64   -0.29   -0.06    0.17    0.56
    Rho_actor[3,3]    1.00    0.00  0.00    1.00    1.00    1.00    1.00    1.00
    Rho_block[1,1]    1.00     NaN  0.00    1.00    1.00    1.00    1.00    1.00
    Rho_block[1,2]   -0.06    0.01  0.31   -0.65   -0.29   -0.07    0.16    0.56
    Rho_block[1,3]    0.03    0.00  0.32   -0.57   -0.20    0.03    0.26    0.63
    Rho_block[2,1]   -0.06    0.01  0.31   -0.65   -0.29   -0.07    0.16    0.56
    Rho_block[2,2]    1.00    0.00  0.00    1.00    1.00    1.00    1.00    1.00
    Rho_block[2,3]   -0.05    0.00  0.32   -0.64   -0.27   -0.05    0.18    0.58
    Rho_block[3,1]    0.03    0.00  0.32   -0.57   -0.20    0.03    0.26    0.63
    Rho_block[3,2]   -0.05    0.00  0.32   -0.64   -0.27   -0.05    0.18    0.58
    Rho_block[3,3]    1.00    0.00  0.00    1.00    1.00    1.00    1.00    1.00
    lp__           -251.19    0.64 12.28 -273.25 -259.63 -252.09 -243.59 -225.28
                   n_eff Rhat
    bpc_actor[1]    4220 1.00
    bpc_actor[2]    2668 1.00
    bpc_actor[3]    1698 1.00
    bpc_actor[4]    2979 1.00
    bpc_actor[5]    2697 1.00
    bpc_actor[6]    2768 1.00
    bpc_actor[7]    1539 1.00
    bp_actor[1]     2359 1.00
    bp_actor[2]     1549 1.00
    bp_actor[3]     1926 1.00
    bp_actor[4]     2439 1.00
    bp_actor[5]     2525 1.00
    bp_actor[6]     2230 1.00
    bp_actor[7]     2745 1.00
    a_actor[1]      1355 1.00
    a_actor[2]      2638 1.00
    a_actor[3]      1439 1.00
    a_actor[4]      1413 1.00
    a_actor[5]      1337 1.00
    a_actor[6]      1345 1.00
    a_actor[7]      1554 1.00
    bpc_block[1]    1570 1.00
    bpc_block[2]    2224 1.00
    bpc_block[3]    2360 1.00
    bpc_block[4]    3057 1.00
    bpc_block[5]    2753 1.00
    bpc_block[6]    3163 1.00
    bp_block[1]     2282 1.00
    bp_block[2]     2251 1.00
    bp_block[3]     2085 1.00
    bp_block[4]     2411 1.00
    bp_block[5]     3092 1.00
    bp_block[6]     1413 1.00
    a_block[1]      1947 1.00
    a_block[2]      2493 1.00
    a_block[3]      1986 1.00
    a_block[4]      3390 1.00
    a_block[5]      3484 1.00
    a_block[6]      2141 1.00
    a               1313 1.00
    bp              2439 1.00
    bpc             2609 1.00
    sigma_actor[1]  3874 1.00
    sigma_actor[2]   814 1.00
    sigma_actor[3]   951 1.00
    sigma_block[1]  1096 1.00
    sigma_block[2]  1356 1.00
    sigma_block[3]  1109 1.00
    Rho_actor[1,1]   NaN  NaN
    Rho_actor[1,2]  3766 1.00
    Rho_actor[1,3]  3052 1.00
    Rho_actor[2,1]  3766 1.00
    Rho_actor[2,2] 10943 1.00
    Rho_actor[2,3]  4210 1.00
    Rho_actor[3,1]  3052 1.00
    Rho_actor[3,2]  4210 1.00
    Rho_actor[3,3]  8994 1.00
    Rho_block[1,1]   NaN  NaN
    Rho_block[1,2]  3441 1.00
    Rho_block[1,3]  5484 1.00
    Rho_block[2,1]  3441 1.00
    Rho_block[2,2] 11102 1.00
    Rho_block[2,3]  4267 1.00
    Rho_block[3,1]  5484 1.00
    Rho_block[3,2]  4267 1.00
    Rho_block[3,3]  7014 1.00
    lp__             372 1.01    
"""

