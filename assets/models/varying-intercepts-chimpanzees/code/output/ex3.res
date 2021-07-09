Chains MCMC chain (1000×23×1 Array{Float64, 3}):

Iterations        = 501:1:1500
Number of chains  = 1
Samples per chain = 1000
Wall duration     = 16.25 seconds
Compute duration  = 16.25 seconds
parameters        = α, α_actor[3], α_actor[7], α_actor[6], α_actor[1], α_actor[4], α_actor[2], σ_actor, α_actor[5], βp, βpC
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64    Float64   Float64       Float64

     σ_actor    2.3283    0.9745     0.0308    0.0622   245.6740    0.9991       15.1156
  α_actor[1]   -1.2855    1.1520     0.0364    0.0700   147.0738    0.9990        9.0490
  α_actor[2]    4.1384    1.6451     0.0520    0.0710   384.4813    0.9990       23.6560
  α_actor[3]   -1.5974    1.1568     0.0366    0.0724   146.8539    0.9990        9.0355
  α_actor[4]   -1.5776    1.1561     0.0366    0.0721   148.2549    0.9991        9.1217
  α_actor[5]   -1.2923    1.1538     0.0365    0.0672   151.5998    0.9991        9.3275
  α_actor[6]   -0.3550    1.1604     0.0367    0.0733   148.9696    0.9991        9.1657
  α_actor[7]    1.1924    1.1689     0.0370    0.0706   158.0406    0.9990        9.7238
           α    0.5698    1.1367     0.0359    0.0694   146.5986    0.9992        9.0198
          βp    0.8303    0.2579     0.0082    0.0111   662.6818    1.0068       40.7729
         βpC   -0.1429    0.2992     0.0095    0.0089   641.0421    0.9998       39.4415

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol   Float64   Float64   Float64   Float64   Float64

     σ_actor    1.1449    1.6583    2.1156    2.7348    4.8391
  α_actor[1]   -4.1733   -1.8091   -1.1774   -0.5477    0.7028
  α_actor[2]    1.4814    3.0265    3.9880    5.1005    7.9054
  α_actor[3]   -4.4279   -2.1524   -1.4758   -0.8923    0.2923
  α_actor[4]   -4.5354   -2.0799   -1.4515   -0.8297    0.4032
  α_actor[5]   -4.1551   -1.8282   -1.1719   -0.5754    0.6383
  α_actor[6]   -3.3066   -0.9104   -0.2197    0.3618    1.6376
  α_actor[7]   -1.7522    0.6478    1.2977    1.9200    3.1474
           α   -1.3467   -0.1549    0.4393    1.1132    3.3263
          βp    0.3387    0.6406    0.8301    1.0093    1.3005
         βpC   -0.7312   -0.3448   -0.1495    0.0536    0.4606
