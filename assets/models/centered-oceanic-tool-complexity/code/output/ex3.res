Chains MCMC chain (1000×16×1 Array{Float64, 3}):

Iterations        = 501:1:1500
Number of chains  = 1
Samples per chain = 1000
Wall duration     = 3.41 seconds
Compute duration  = 3.41 seconds
parameters        = α, βp, βc, βpc
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64    Float64   Float64       Float64

           α    3.3080    0.0901     0.0028    0.0037   714.0783    1.0069      209.5300
          βp    0.2623    0.0363     0.0011    0.0014   773.7110    0.9995      227.0279
          βc    0.2876    0.1196     0.0038    0.0048   723.8301    1.0053      212.3915
         βpc    0.0627    0.1746     0.0055    0.0054   803.7383    0.9990      235.8387

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol   Float64   Float64   Float64   Float64   Float64

           α    3.1246    3.2481    3.3111    3.3717    3.4747
          βp    0.1896    0.2388    0.2627    0.2865    0.3348
          βc    0.0683    0.2035    0.2849    0.3672    0.5283
         βpc   -0.2845   -0.0591    0.0608    0.1812    0.4103
