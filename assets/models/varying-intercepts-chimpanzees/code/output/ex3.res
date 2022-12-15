Chains MCMC chain (1000×23×1 Array{Float64, 3}):

Iterations        = 501:1:1500
Number of chains  = 1
Samples per chain = 1000
Wall duration     = 20.92 seconds
Compute duration  = 20.92 seconds
parameters        = σ_actor, α_actor[1], α_actor[2], α_actor[3], α_actor[4], α_actor[5], α_actor[6], α_actor[7], α, βp, βpC
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters      mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64    Float64   Float64       Float64

     σ_actor    2.3051    0.9881     0.0312    0.0743   158.7163    1.0002        7.5861
  α_actor[1]   -1.2867    1.0601     0.0335    0.0965    92.5074    1.0069        4.4215
  α_actor[2]    4.1051    1.6267     0.0514    0.0756   379.9454    0.9999       18.1601
  α_actor[3]   -1.5682    1.0706     0.0339    0.0993    88.9685    1.0064        4.2524
  α_actor[4]   -1.5764    1.0534     0.0333    0.0977    92.9265    1.0050        4.4416
  α_actor[5]   -1.2777    1.0665     0.0337    0.0971    95.7129    1.0049        4.5748
  α_actor[6]   -0.3330    1.0581     0.0335    0.0966    92.7081    1.0058        4.4311
  α_actor[7]    1.2000    1.0951     0.0346    0.0998    93.1600    1.0074        4.4527
           α    0.5634    1.0382     0.0328    0.0967    89.5140    1.0068        4.2785
          βp    0.8177    0.2438     0.0077    0.0093   732.8422    1.0019       35.0274
         βpC   -0.1263    0.2853     0.0090    0.0101   792.4163    0.9998       37.8748

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol   Float64   Float64   Float64   Float64   Float64

     σ_actor    1.1069    1.6692    2.0581    2.6542    4.8785
  α_actor[1]   -4.1357   -1.6900   -1.1658   -0.6658    0.5522
  α_actor[2]    1.5941    3.0604    3.7703    4.8946    8.1172
  α_actor[3]   -4.3841   -2.0164   -1.4599   -0.9437    0.1821
  α_actor[4]   -4.3581   -2.0031   -1.4407   -0.9603    0.1654
  α_actor[5]   -4.0121   -1.6895   -1.1536   -0.7022    0.5674
  α_actor[6]   -3.1881   -0.7475   -0.1801    0.2731    1.4832
  α_actor[7]   -1.4838    0.7121    1.3188    1.8460    3.0982
           α   -1.2412    0.0050    0.4453    0.9926    3.2768
          βp    0.3668    0.6379    0.8095    0.9873    1.2937
         βpC   -0.7055   -0.3144   -0.1180    0.0614    0.4223
