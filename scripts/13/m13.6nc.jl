using TuringModels
using LinearAlgebra

# This script requires latest LKJ bijectors support.
# `] add Bijectors#master` to get latest Bijectors.

data_path = joinpath(@__DIR__, "..", "..", "data", "chimpanzees.csv")
delim = ";"
d = CSV.read(data_path, DataFrame; delim)

d.block_id = d.block

# m13.6nc1 is equivalent to m13.6nc in following Turing model

@model m13_6_nc(actor, block_id, condition, prosoc_left, pulled_left) = begin
    # fixed priors
    Rho_block ~ LKJ(3, 4.)
    Rho_actor ~ LKJ(3, 4.)
    sigma_block ~ filldist(truncated(Cauchy(0, 2), 0, Inf), 3)
    sigma_actor ~ filldist(truncated(Cauchy(0, 2), 0, Inf), 3)
    a ~ Normal(0, 1)
    bp ~ Normal(0, 1)
    bpc ~ Normal(0, 1)
    
    # adaptive NON-CENTERED priors
    Rho_block = (Rho_block' + Rho_block) / 2
    Rho_actor = (Rho_actor' + Rho_actor) / 2
    
    L_Rho_block = cholesky(Rho_block).L
    L_Rho_actor = cholesky(Rho_actor).L
    
    z_N_block ~ filldist(Normal(0, 1), 3, 6)
    z_N_actor ~ filldist(Normal(0, 1), 3, 7)
    
    # @show size(L_Rho_block) size(sigma_block) size(z_N_block_id)
    
    a_block_bp_block_bpc_block = sigma_block .* L_Rho_block * z_N_block
    a_actor_bp_actor_bpc_actor = sigma_actor .* L_Rho_actor * z_N_actor
    
    a_block = a_block_bp_block_bpc_block[1, :]
    bp_block = a_block_bp_block_bpc_block[2, :]
    bpc_block = a_block_bp_block_bpc_block[3, :]
    a_actor = a_actor_bp_actor_bpc_actor[1, :]
    bp_actor = a_actor_bp_actor_bpc_actor[2, :]
    bpc_actor = a_actor_bp_actor_bpc_actor[3, :]
    
    # linear models
    BPC = bpc .+ bpc_actor[actor] + bpc_block[block_id]
    BP = bp .+ bp_actor[actor] + bp_block[block_id]
    A = a .+ a_actor[actor] + a_block[block_id]
    logit_p = A + (BP + BPC .* condition) .* prosoc_left
    
    # likelihood
    pulled_left .~ BinomialLogit.(1, logit_p)
end

chns = sample(
    m13_6_nc(d.actor, d.block_id, d.condition, d.prosoc_left, d.pulled_left),
    Turing.NUTS(0.95),
    1000
)

chns |> display

m_13_6_nc_rethinking = """
Inference for Stan model: 78757717ec3ffa528c3819708907eb7f.
    3 chains, each with iter=5000; warmup=1000; thin=1; 
    post-warmup draws per chain=4000, total post-warmup draws=12000.
    
                         mean se_mean   sd    2.5%     25%     50%     75%   97.5%
    z_N_block_id[1,1]   -0.44    0.01 0.90   -2.17   -1.03   -0.46    0.13    1.39
    z_N_block_id[1,2]    0.21    0.01 0.86   -1.50   -0.35    0.22    0.78    1.89
    z_N_block_id[1,3]    0.34    0.01 0.87   -1.42   -0.22    0.35    0.92    2.02
    z_N_block_id[1,4]   -0.02    0.01 0.84   -1.71   -0.56   -0.03    0.52    1.63
    z_N_block_id[1,5]   -0.09    0.01 0.84   -1.73   -0.64   -0.10    0.47    1.56
    z_N_block_id[1,6]    0.01    0.01 0.92   -1.85   -0.59    0.03    0.63    1.80
    z_N_block_id[2,1]   -0.37    0.01 0.82   -1.99   -0.90   -0.37    0.15    1.27
    z_N_block_id[2,2]   -0.18    0.01 0.78   -1.76   -0.66   -0.17    0.31    1.38
    z_N_block_id[2,3]   -0.36    0.01 0.79   -1.93   -0.87   -0.35    0.16    1.18
    z_N_block_id[2,4]    0.23    0.01 0.77   -1.33   -0.26    0.23    0.72    1.74
    z_N_block_id[2,5]    0.04    0.01 0.76   -1.49   -0.46    0.04    0.52    1.58
    z_N_block_id[2,6]    1.01    0.01 0.84   -0.76    0.49    1.04    1.56    2.58
    z_N_block_id[3,1]   -0.59    0.01 0.91   -2.32   -1.20   -0.61    0.00    1.28
    z_N_block_id[3,2]    0.28    0.01 0.88   -1.50   -0.29    0.28    0.86    2.04
    z_N_block_id[3,3]    0.32    0.01 0.89   -1.46   -0.26    0.34    0.91    2.09
    z_N_block_id[3,4]   -0.11    0.01 0.89   -1.87   -0.69   -0.10    0.46    1.64
    z_N_block_id[3,5]   -0.12    0.01 0.86   -1.83   -0.68   -0.12    0.43    1.64
    z_N_block_id[3,6]    0.20    0.01 0.91   -1.63   -0.40    0.20    0.81    1.99
    L_Rho_block[1,1]     1.00     NaN 0.00    1.00    1.00    1.00    1.00    1.00
    L_Rho_block[1,2]     0.00     NaN 0.00    0.00    0.00    0.00    0.00    0.00
    L_Rho_block[1,3]     0.00     NaN 0.00    0.00    0.00    0.00    0.00    0.00
    L_Rho_block[2,1]    -0.06    0.00 0.32   -0.65   -0.29   -0.06    0.17    0.57
    L_Rho_block[2,2]     0.94    0.00 0.07    0.73    0.92    0.97    0.99    1.00
    L_Rho_block[2,3]     0.00     NaN 0.00    0.00    0.00    0.00    0.00    0.00
    L_Rho_block[3,1]     0.04    0.00 0.32   -0.57   -0.19    0.04    0.27    0.63
    L_Rho_block[3,2]    -0.04    0.00 0.31   -0.62   -0.26   -0.04    0.18    0.57
    L_Rho_block[3,3]     0.89    0.00 0.10    0.64    0.84    0.92    0.97    1.00
    z_N_actor[1,1]      -0.49    0.01 0.36   -1.25   -0.71   -0.46   -0.24    0.15
    z_N_actor[1,2]       1.99    0.01 0.62    0.88    1.55    1.96    2.40    3.29
    z_N_actor[1,3]      -0.63    0.01 0.38   -1.44   -0.87   -0.60   -0.35    0.04
    z_N_actor[1,4]      -0.65    0.01 0.39   -1.48   -0.89   -0.61   -0.37    0.03
    z_N_actor[1,5]      -0.48    0.01 0.36   -1.25   -0.71   -0.45   -0.23    0.15
    z_N_actor[1,6]       0.09    0.00 0.33   -0.56   -0.13    0.09    0.30    0.75
    z_N_actor[1,7]       0.73    0.01 0.41    0.04    0.45    0.69    0.98    1.62
    z_N_actor[2,1]       0.06    0.01 0.83   -1.60   -0.49    0.07    0.59    1.71
    z_N_actor[2,2]       0.14    0.01 0.99   -1.80   -0.52    0.14    0.81    2.07
    z_N_actor[2,3]       0.38    0.01 0.86   -1.34   -0.18    0.38    0.95    2.04
    z_N_actor[2,4]       0.25    0.01 0.85   -1.46   -0.29    0.26    0.81    1.91
    z_N_actor[2,5]       0.13    0.01 0.84   -1.57   -0.41    0.13    0.68    1.79
    z_N_actor[2,6]      -0.62    0.01 0.87   -2.26   -1.20   -0.65   -0.09    1.20
    z_N_actor[2,7]      -0.04    0.01 0.92   -1.84   -0.66   -0.04    0.58    1.78
    z_N_actor[3,1]       0.10    0.01 0.86   -1.63   -0.46    0.10    0.67    1.81
    z_N_actor[3,2]       0.07    0.01 0.98   -1.84   -0.60    0.08    0.74    1.98
    z_N_actor[3,3]      -0.35    0.01 0.86   -2.02   -0.94   -0.37    0.22    1.38
    z_N_actor[3,4]       0.02    0.01 0.86   -1.70   -0.55    0.01    0.58    1.73
    z_N_actor[3,5]      -0.05    0.01 0.85   -1.73   -0.62   -0.06    0.50    1.65
    z_N_actor[3,6]      -0.25    0.01 0.89   -1.97   -0.83   -0.26    0.31    1.56
    z_N_actor[3,7]       0.50    0.01 0.97   -1.43   -0.13    0.50    1.16    2.38
    L_Rho_actor[1,1]     1.00     NaN 0.00    1.00    1.00    1.00    1.00    1.00
    L_Rho_actor[1,2]     0.00     NaN 0.00    0.00    0.00    0.00    0.00    0.00
    L_Rho_actor[1,3]     0.00     NaN 0.00    0.00    0.00    0.00    0.00    0.00
    L_Rho_actor[2,1]    -0.07    0.00 0.32   -0.65   -0.30   -0.07    0.15    0.56
    L_Rho_actor[2,2]     0.94    0.00 0.07    0.73    0.92    0.97    0.99    1.00
    L_Rho_actor[2,3]     0.00     NaN 0.00    0.00    0.00    0.00    0.00    0.00
    L_Rho_actor[3,1]     0.08    0.00 0.32   -0.55   -0.15    0.09    0.31    0.66
    L_Rho_actor[3,2]    -0.04    0.00 0.31   -0.64   -0.27   -0.05    0.18    0.57
    L_Rho_actor[3,3]     0.88    0.00 0.10    0.61    0.83    0.91    0.96    1.00
    a                    0.24    0.01 0.66   -1.06   -0.19    0.24    0.67    1.56
    bp                   0.72    0.00 0.40   -0.14    0.47    0.73    0.98    1.48
    bpc                 -0.03    0.00 0.44   -0.88   -0.31   -0.03    0.25    0.88
    sigma_actor[1]       2.35    0.01 0.90    1.20    1.73    2.16    2.75    4.67
    sigma_actor[2]       0.46    0.00 0.37    0.02    0.19    0.39    0.64    1.37
    sigma_actor[3]       0.53    0.01 0.49    0.02    0.19    0.40    0.72    1.81
    sigma_block[1]       0.23    0.00 0.20    0.01    0.09    0.18    0.31    0.74
    sigma_block[2]       0.57    0.01 0.41    0.03    0.29    0.50    0.77    1.56
    sigma_block[3]       0.52    0.01 0.43    0.02    0.20    0.42    0.72    1.59
    a_block[1]          -0.12    0.00 0.23   -0.68   -0.22   -0.06    0.01    0.23
    a_block[2]           0.06    0.00 0.21   -0.32   -0.04    0.02    0.14    0.57
    a_block[3]           0.10    0.00 0.22   -0.27   -0.02    0.04    0.19    0.65
    a_block[4]          -0.01    0.00 0.20   -0.44   -0.09    0.00    0.08    0.42
    a_block[5]          -0.02    0.00 0.20   -0.49   -0.11   -0.01    0.06    0.39
    a_block[6]           0.00    0.00 0.22   -0.49   -0.09    0.00    0.10    0.46
    bp_block[1]         -0.18    0.00 0.42   -1.12   -0.42   -0.14    0.05    0.64
    bp_block[2]         -0.11    0.00 0.41   -0.99   -0.32   -0.07    0.11    0.70
    bp_block[3]         -0.23    0.00 0.43   -1.24   -0.46   -0.16    0.03    0.54
    bp_block[4]          0.15    0.00 0.41   -0.59   -0.08    0.09    0.37    1.11
    bp_block[5]          0.04    0.00 0.40   -0.75   -0.18    0.01    0.24    0.92
    bp_block[6]          0.63    0.01 0.57   -0.14    0.17    0.53    0.96    1.98
    bpc_block[1]        -0.37    0.01 0.54   -1.75   -0.63   -0.22   -0.01    0.38
    bpc_block[2]         0.18    0.00 0.44   -0.57   -0.05    0.09    0.39    1.28
    bpc_block[3]         0.22    0.00 0.47   -0.56   -0.04    0.11    0.43    1.40
    bpc_block[4]        -0.08    0.00 0.45   -1.11   -0.28   -0.03    0.12    0.82
    bpc_block[5]        -0.07    0.00 0.42   -1.02   -0.26   -0.03    0.12    0.78
    bpc_block[6]         0.09    0.00 0.48   -0.88   -0.13    0.04    0.30    1.19
    Rho_block[1,1]       1.00     NaN 0.00    1.00    1.00    1.00    1.00    1.00
    Rho_block[1,2]      -0.06    0.00 0.32   -0.65   -0.29   -0.06    0.17    0.57
    Rho_block[1,3]       0.04    0.00 0.32   -0.57   -0.19    0.04    0.27    0.63
    Rho_block[2,1]      -0.06    0.00 0.32   -0.65   -0.29   -0.06    0.17    0.57
    Rho_block[2,2]       1.00    0.00 0.00    1.00    1.00    1.00    1.00    1.00
    Rho_block[2,3]      -0.04    0.00 0.31   -0.62   -0.27   -0.05    0.18    0.57
    Rho_block[3,1]       0.04    0.00 0.32   -0.57   -0.19    0.04    0.27    0.63
    Rho_block[3,2]      -0.04    0.00 0.31   -0.62   -0.27   -0.05    0.18    0.57
    Rho_block[3,3]       1.00    0.00 0.00    1.00    1.00    1.00    1.00    1.00
    a_actor[1]          -1.02    0.01 0.71   -2.43   -1.48   -1.01   -0.55    0.38
    a_actor[2]           4.44    0.02 1.63    2.09    3.36    4.17    5.21    8.34
    a_actor[3]          -1.31    0.01 0.72   -2.75   -1.77   -1.30   -0.83    0.11
    a_actor[4]          -1.35    0.01 0.72   -2.80   -1.82   -1.34   -0.88    0.10
    a_actor[5]          -1.00    0.01 0.71   -2.42   -1.48   -0.99   -0.53    0.40
    a_actor[6]           0.20    0.01 0.72   -1.24   -0.28    0.20    0.66    1.60
    a_actor[7]           1.55    0.01 0.76    0.10    1.05    1.53    2.04    3.08
    bp_actor[1]          0.05    0.00 0.37   -0.68   -0.13    0.02    0.22    0.89
    bp_actor[2]          0.03    0.01 0.64   -1.21   -0.24    0.00    0.25    1.46
    bp_actor[3]          0.22    0.00 0.42   -0.44   -0.02    0.12    0.41    1.25
    bp_actor[4]          0.16    0.00 0.39   -0.52   -0.05    0.08    0.34    1.09
    bp_actor[5]          0.10    0.00 0.38   -0.61   -0.09    0.04    0.26    0.99
    bp_actor[6]         -0.31    0.00 0.42   -1.35   -0.54   -0.21   -0.01    0.28
    bp_actor[7]         -0.04    0.00 0.43   -1.00   -0.23   -0.02    0.15    0.87
    bpc_actor[1]         0.02    0.00 0.42   -0.92   -0.15    0.01    0.20    0.94
    bpc_actor[2]         0.20    0.01 0.83   -1.18   -0.13    0.05    0.41    2.31
    bpc_actor[3]        -0.28    0.01 0.50   -1.58   -0.49   -0.14    0.02    0.46
    bpc_actor[4]        -0.05    0.00 0.43   -1.05   -0.22   -0.01    0.15    0.79
    bpc_actor[5]        -0.08    0.00 0.43   -1.13   -0.25   -0.02    0.12    0.73
    bpc_actor[6]        -0.14    0.00 0.45   -1.25   -0.32   -0.05    0.08    0.69
    bpc_actor[7]         0.41    0.01 0.73   -0.41   -0.01    0.18    0.64    2.39
    Rho_actor[1,1]       1.00     NaN 0.00    1.00    1.00    1.00    1.00    1.00
    Rho_actor[1,2]      -0.07    0.00 0.32   -0.65   -0.30   -0.07    0.15    0.56
    Rho_actor[1,3]       0.08    0.00 0.32   -0.55   -0.15    0.09    0.31    0.66
    Rho_actor[2,1]      -0.07    0.00 0.32   -0.65   -0.30   -0.07    0.15    0.56
    Rho_actor[2,2]       1.00    0.00 0.00    1.00    1.00    1.00    1.00    1.00
    Rho_actor[2,3]      -0.05    0.00 0.32   -0.63   -0.28   -0.05    0.17    0.56
    Rho_actor[3,1]       0.08    0.00 0.32   -0.55   -0.15    0.09    0.31    0.66
    Rho_actor[3,2]      -0.05    0.00 0.32   -0.63   -0.28   -0.05    0.17    0.56
    Rho_actor[3,3]       1.00    0.00 0.00    1.00    1.00    1.00    1.00    1.00
    lp__              -285.47    0.11 6.46 -299.01 -289.56 -285.23 -281.02 -273.65
                      n_eff Rhat
    z_N_block_id[1,1] 13367    1
    z_N_block_id[1,2] 16316    1
    z_N_block_id[1,3] 13212    1
    z_N_block_id[1,4] 16245    1
    z_N_block_id[1,5] 14391    1
    z_N_block_id[1,6] 13216    1
    z_N_block_id[2,1] 11937    1
    z_N_block_id[2,2] 11867    1
    z_N_block_id[2,3] 12192    1
    z_N_block_id[2,4] 14644    1
    z_N_block_id[2,5] 13497    1
    z_N_block_id[2,6] 10467    1
    z_N_block_id[3,1] 15608    1
    z_N_block_id[3,2] 15577    1
    z_N_block_id[3,3] 17322    1
    z_N_block_id[3,4] 16464    1
    z_N_block_id[3,5] 17740    1
    z_N_block_id[3,6] 15742    1
    L_Rho_block[1,1]    NaN  NaN
    L_Rho_block[1,2]    NaN  NaN
    L_Rho_block[1,3]    NaN  NaN
    L_Rho_block[2,1]  13964    1
    L_Rho_block[2,2]   6881    1
    L_Rho_block[2,3]    NaN  NaN
    L_Rho_block[3,1]  18184    1
    L_Rho_block[3,2]  17024    1
    L_Rho_block[3,3]   5530    1
    z_N_actor[1,1]     3997    1
    z_N_actor[1,2]     8100    1
    z_N_actor[1,3]     4054    1
    z_N_actor[1,4]     4042    1
    z_N_actor[1,5]     4067    1
    z_N_actor[1,6]     4812    1
    z_N_actor[1,7]     5978    1
    z_N_actor[2,1]    17688    1
    z_N_actor[2,2]    19821    1
    z_N_actor[2,3]    15620    1
    z_N_actor[2,4]    15806    1
    z_N_actor[2,5]    16515    1
    z_N_actor[2,6]    13494    1
    z_N_actor[2,7]    19772    1
    z_N_actor[3,1]    16698    1
    z_N_actor[3,2]    25570    1
    z_N_actor[3,3]    15609    1
    z_N_actor[3,4]    17747    1
    z_N_actor[3,5]    16452    1
    z_N_actor[3,6]    16474    1
    z_N_actor[3,7]    17924    1
    L_Rho_actor[1,1]    NaN  NaN
    L_Rho_actor[1,2]    NaN  NaN
    L_Rho_actor[1,3]    NaN  NaN
    L_Rho_actor[2,1]  20181    1
    L_Rho_actor[2,2]   5099    1
    L_Rho_actor[2,3]    NaN  NaN
    L_Rho_actor[3,1]  16979    1
    L_Rho_actor[3,2]  16551    1
    L_Rho_actor[3,3]   5465    1
    a                  4604    1
    bp                 9915    1
    bpc               10895    1
    sigma_actor[1]     4844    1
    sigma_actor[2]     7378    1
    sigma_actor[3]     6330    1
    sigma_block[1]     7461    1
    sigma_block[2]     5026    1
    sigma_block[3]     6372    1
    a_block[1]        11376    1
    a_block[2]        14094    1
    a_block[3]        11484    1
    a_block[4]        14446    1
    a_block[5]        12892    1
    a_block[6]        12830    1
    bp_block[1]       10766    1
    bp_block[2]       11464    1
    bp_block[3]       10088    1
    bp_block[4]       10004    1
    bp_block[5]       10791    1
    bp_block[6]        6266    1
    bpc_block[1]       9908    1
    bpc_block[2]      11090    1
    bpc_block[3]      10070    1
    bpc_block[4]      12510    1
    bpc_block[5]      12340    1
    bpc_block[6]      11472    1
    Rho_block[1,1]      NaN  NaN
    Rho_block[1,2]    13964    1
    Rho_block[1,3]    18184    1
    Rho_block[2,1]    13964    1
    Rho_block[2,2]    11984    1
    Rho_block[2,3]    15006    1
    Rho_block[3,1]    18184    1
    Rho_block[3,2]    15006    1
    Rho_block[3,3]    11786    1
    a_actor[1]         4930    1
    a_actor[2]         7208    1
    a_actor[3]         4880    1
    a_actor[4]         5074    1
    a_actor[5]         4983    1
    a_actor[6]         4827    1
    a_actor[7]         5096    1
    bp_actor[1]       12464    1
    bp_actor[2]       14817    1
    bp_actor[3]       10567    1
    bp_actor[4]       12646    1
    bp_actor[5]       13023    1
    bp_actor[6]       10818    1
    bp_actor[7]       14796    1
    bpc_actor[1]      12189    1
    bpc_actor[2]      12373    1
    bpc_actor[3]       8575    1
    bpc_actor[4]      11896    1
    bpc_actor[5]      10873    1
    bpc_actor[6]      10218    1
    bpc_actor[7]       9055    1
    Rho_actor[1,1]      NaN  NaN
    Rho_actor[1,2]    20181    1
    Rho_actor[1,3]    16979    1
    Rho_actor[2,1]    20181    1
    Rho_actor[2,2]    10875    1
    Rho_actor[2,3]    14880    1
    Rho_actor[3,1]    16979    1
    Rho_actor[3,2]    14880    1
    Rho_actor[3,3]    10080    1
    lp__               3172    1    
"""

# End of m13.6nc.jl
