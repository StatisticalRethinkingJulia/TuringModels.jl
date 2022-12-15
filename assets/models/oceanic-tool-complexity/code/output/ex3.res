Chains MCMC chain (1000×16×1 Array{Float64, 3}):

Iterations        = 501:1:1500
Number of chains  = 1
Samples per chain = 1000
Wall duration     = 10.46 seconds
Compute duration  = 10.46 seconds
parameters        = α, βp, βc, βpc
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64    Float64   Float64       Float64

           α    0.9405    0.3622     0.0115    0.0196   326.1608    1.0046       31.1877
          βp    0.2641    0.0350     0.0011    0.0019   320.7521    1.0046       30.6705
          βc   -0.0679    0.8847     0.0280    0.0500   272.4546    1.0028       26.0523
         βpc    0.0401    0.0968     0.0031    0.0055   274.0906    1.0033       26.2087

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol   Float64   Float64   Float64   Float64   Float64

           α    0.2322    0.6806    0.9625    1.2130    1.5952
          βp    0.2010    0.2382    0.2627    0.2892    0.3355
          βc   -1.7875   -0.6647   -0.0906    0.5256    1.6761
         βpc   -0.1578   -0.0224    0.0420    0.1045    0.2285
