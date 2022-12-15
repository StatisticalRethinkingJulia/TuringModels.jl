Chains MCMC chain (1000×17×1 Array{Float64, 3}):

Iterations        = 501:1:1500
Number of chains  = 1
Samples per chain = 1000
Wall duration     = 30.71 seconds
Compute duration  = 30.71 seconds
parameters        = σ, βAR, βR, βA, α
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64    Float64   Float64       Float64

           σ    0.9124    0.1038     0.0033    0.0041   564.1423    0.9991       18.3718
         βAR   -0.4022    6.7703     0.2141    0.3039   364.0892    0.9994       11.8569
          βR    0.5288    6.7725     0.2142    0.3031   365.8438    0.9994       11.9140
          βA    0.3043    9.7038     0.3069    0.4403   360.1388    0.9991       11.7282
           α    7.0447    9.7034     0.3068    0.4383   361.5474    0.9991       11.7741

Quantiles
  parameters       2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol    Float64   Float64   Float64   Float64   Float64

           σ     0.7276    0.8384    0.9056    0.9736    1.1367
         βAR   -13.7031   -5.0066   -0.4931    4.1581   12.3653
          βR   -12.2815   -4.0114    0.5909    5.1958   13.9103
          βA   -19.2804   -6.0694   -0.1506    6.9126   19.6269
           α   -12.2354    0.4536    7.4986   13.4632   26.5998
