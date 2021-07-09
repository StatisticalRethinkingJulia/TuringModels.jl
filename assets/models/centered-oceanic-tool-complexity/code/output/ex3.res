Chains MCMC chain (1000×16×1 Array{Float64, 3}):

Iterations        = 501:1:1500
Number of chains  = 1
Samples per chain = 1000
Wall duration     = 3.87 seconds
Compute duration  = 3.87 seconds
parameters        = α, βc, βpc, βp
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64    Float64   Float64       Float64

           α    3.3119    0.0922     0.0029    0.0041   720.1270    0.9991      186.0312
          βp    0.2616    0.0359     0.0011    0.0012   757.7744    1.0010      195.7568
          βc    0.2844    0.1217     0.0038    0.0057   606.8911    1.0002      156.7789
         βpc    0.0789    0.1698     0.0054    0.0076   740.9271    1.0019      191.4046

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol   Float64   Float64   Float64   Float64   Float64

           α    3.1344    3.2479    3.3130    3.3762    3.4930
          βp    0.1861    0.2370    0.2628    0.2872    0.3275
          βc    0.0429    0.1987    0.2850    0.3649    0.5220
         βpc   -0.2401   -0.0325    0.0759    0.1942    0.3985
