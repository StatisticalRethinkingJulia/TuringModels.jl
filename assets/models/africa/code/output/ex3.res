Chains MCMC chain (1000×17×1 Array{Float64, 3}):

Iterations        = 501:1:1500
Number of chains  = 1
Samples per chain = 1000
Wall duration     = 30.46 seconds
Compute duration  = 30.46 seconds
parameters        = α, σ, βA, βAR, βR
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64    Float64   Float64       Float64

           σ    0.9053    0.0903     0.0029    0.0035   607.4013    0.9996       19.9390
         βAR    0.2779    6.9170     0.2187    0.2428   430.4670    1.0055       14.1308
          βR   -0.1499    6.9146     0.2187    0.2425   431.1465    1.0056       14.1531
          βA    0.3552    9.6949     0.3066    0.2556   417.4278    0.9991       13.7028
           α    6.9874    9.6974     0.3067    0.2555   418.6223    0.9991       13.7420

Quantiles
  parameters       2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol    Float64   Float64   Float64   Float64   Float64

           σ     0.7449    0.8381    0.8989    0.9658    1.0930
         βAR   -12.6285   -4.7956    0.4950    5.0441   13.3228
          βR   -13.1304   -4.9610   -0.3850    4.8602   12.8482
          βA   -19.4538   -5.9288    0.0943    7.1690   18.4802
           α   -11.1071    0.2407    7.1846   13.2846   26.7433
