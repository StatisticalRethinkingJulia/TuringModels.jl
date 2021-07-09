Chains MCMC chain (1000×16×1 Array{Float64, 3}):

Iterations        = 501:1:1500
Number of chains  = 1
Samples per chain = 1000
Wall duration     = 7.98 seconds
Compute duration  = 7.98 seconds
parameters        = α, βc, βpc, βp
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64    Float64   Float64       Float64

           α    0.9428    0.3772     0.0119    0.0221   253.6586    1.0005       31.7748
          βp    0.2639    0.0366     0.0012    0.0021   252.1492    1.0007       31.5858
          βc   -0.0882    0.8644     0.0273    0.0554   395.2002    1.0019       49.5052
         βpc    0.0418    0.0952     0.0030    0.0061   396.6543    1.0028       49.6874

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol   Float64   Float64   Float64   Float64   Float64

           α    0.2630    0.6781    0.9270    1.1879    1.7567
          βp    0.1869    0.2402    0.2660    0.2886    0.3300
          βc   -1.7400   -0.6629   -0.1098    0.5067    1.6593
         βpc   -0.1485   -0.0231    0.0469    0.1039    0.2212
