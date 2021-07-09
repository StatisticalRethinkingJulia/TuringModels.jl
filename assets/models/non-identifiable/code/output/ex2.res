Chains MCMC chain (2000×15×1 Array{Float64, 3}):

Iterations        = 1001:1:3000
Number of chains  = 1
Samples per chain = 2000
Wall duration     = 24.56 seconds
Compute duration  = 24.56 seconds
parameters        = σ, α₂, α₁
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters         mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol      Float64   Float64    Float64   Float64    Float64   Float64       Float64

          α₁   -2952.0314   29.8656     0.6678    3.2652   107.5325    1.0083        4.3793
          α₂    2951.9869   29.8670     0.6678    3.2653   107.5030    1.0083        4.3780
           σ       1.0297    0.0820     0.0018    0.0087    78.8378    1.0181        3.2107

Quantiles
  parameters         2.5%        25.0%        50.0%        75.0%        97.5%
      Symbol      Float64      Float64      Float64      Float64      Float64

          α₁   -2995.4647   -2977.6737   -2955.9139   -2927.3799   -2896.6027
          α₂    2896.5861    2927.3468    2955.8696    2977.6266    2995.4430
           σ       0.8847       0.9709       1.0246       1.0828       1.2011
