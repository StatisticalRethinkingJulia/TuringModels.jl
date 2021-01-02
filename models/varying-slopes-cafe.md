+++
title = "Varying slopes cafes"
+++

On page 441 of McElreath (2020), `m14.1` is defined as

$$
\begin{aligned}
  W_i &\sim \text{Normal}(\mu_i, \sigma) \\
  \mu_i &= \alpha_\text{café}[i] + \beta_\text{café}[i] A_i \\
  \alpha &\sim \text{Normal}(5, 2) \\
  \beta &\sim \text{Normal}(-1, 0.5) \\
  \sigma &\sim \text{Exponential}(1) \\
  \sigma_\alpha &\sim \text{Exponential}(1) \\
  \sigma_\beta &\sim \text{Exponential}(1) \\
  \textbf{R} &\sim \text{LKJcorr}(2) 
\end{aligned}
$$

\toc 

## Data

```julia:data
import CSV

using DataFrames
using TuringModels

data_path = joinpath(TuringModels.project_root, "data", "d_13_1.csv")
df = CSV.read(data_path, DataFrame)
write_csv(name, data) = CSV.write(joinpath(@OUTPUT, "$name.csv"), data) # hide
write_csv("data", df) # hide
```
\output{data}

DataFrame `df` is shown in [Appendix I](#appendix_i).

## Model

```julia:model
using Turing

@model m13_1(cafe, afternoon, wait) = begin
    Rho ~ LKJ(2, 1.)
    sigma ~ truncated(Cauchy(0, 2), 0, Inf)
    sigma_cafe ~ filldist(truncated(Cauchy(0, 2), 0, Inf), 2)
    a ~ Normal(0, 10)
    b ~ Normal(0, 10)
    
    dist_mu = [a, b]
    dist_Sigma = sigma_cafe .* Rho .* sigma_cafe'
    dist_Sigma = (dist_Sigma' + dist_Sigma) / 2
    a_b_cafe ~ filldist(MvNormal(dist_mu, dist_Sigma), 20)
    
    a_cafe = a_b_cafe[1, :]
    b_cafe = a_b_cafe[2, :]
        
    μ = a_cafe[cafe] + b_cafe[cafe] .* afternoon
    wait .~ Normal.(μ, sigma)
end

chains = sample(
    m13_1(df.cafe, df.afternoon, df.wait),
    # This model fails on NUTS(0.65).
    Turing.NUTS(0.95),
    1000
)
```
\output{model}

## Output

```julia:write_helper
# hideall
output_dir = @OUTPUT 
function write_svg(name, p) 
  fig_path = joinpath(output_dir, "$name.svg")
  StatsPlots.savefig(fig_path)
end
```
\output{write_helper}

```julia:plot
using StatsPlots

write_svg("chains", # hide
StatsPlots.plot(chains)
) # hide
```
\output{plot}
\fig{chains.svg}

```!
describe(chains)[1] 
```

```!
describe(chains)[2]
```

## Original output

```
Inference for Stan model: a73b0bd01032773825c6abf5575fd6e4.
    2 chains, each with iter=5000; warmup=2000; thin=1; 
    post-warmup draws per chain=3000, total post-warmup draws=6000.
    
                   mean se_mean    sd  2.5%   25%   50%   75%  97.5% n_eff Rhat
    b_cafe[1]     -1.29    0.00  0.18 -1.69 -1.40 -1.28 -1.18  -0.96  2548 1.00
    b_cafe[2]     -1.20    0.00  0.18 -1.57 -1.31 -1.21 -1.09  -0.83  3288 1.00
    b_cafe[3]     -1.26    0.00  0.18 -1.63 -1.36 -1.25 -1.15  -0.91  4302 1.00
    b_cafe[4]     -1.29    0.00  0.18 -1.68 -1.39 -1.28 -1.18  -0.96  2960 1.00
    b_cafe[5]     -1.26    0.00  0.20 -1.68 -1.38 -1.25 -1.14  -0.88  3406 1.00
    b_cafe[6]     -1.28    0.00  0.18 -1.66 -1.38 -1.27 -1.17  -0.93  2983 1.00
    b_cafe[7]     -1.23    0.00  0.18 -1.62 -1.33 -1.23 -1.13  -0.86  4430 1.00
    b_cafe[8]     -1.25    0.00  0.17 -1.62 -1.35 -1.24 -1.15  -0.90  3838 1.00
    b_cafe[9]     -1.13    0.01  0.19 -1.45 -1.26 -1.16 -1.02  -0.70  1372 1.00
    b_cafe[10]    -1.19    0.00  0.18 -1.54 -1.30 -1.20 -1.09  -0.80  3924 1.00
    b_cafe[11]    -1.04    0.01  0.22 -1.38 -1.20 -1.07 -0.90  -0.55   416 1.01
    b_cafe[12]    -1.21    0.00  0.18 -1.55 -1.32 -1.22 -1.11  -0.82  3781 1.00
    b_cafe[13]    -1.32    0.00  0.19 -1.76 -1.43 -1.30 -1.20  -0.99  1509 1.00
    b_cafe[14]    -1.37    0.01  0.20 -1.82 -1.49 -1.34 -1.23  -1.04   760 1.01
    b_cafe[15]    -1.52    0.02  0.27 -2.11 -1.70 -1.49 -1.31  -1.13   161 1.02
    b_cafe[16]    -1.18    0.00  0.18 -1.51 -1.29 -1.20 -1.08  -0.79  3430 1.00
    b_cafe[17]    -1.16    0.00  0.19 -1.50 -1.28 -1.18 -1.05  -0.73  2034 1.00
    b_cafe[18]    -1.28    0.00  0.21 -1.72 -1.41 -1.28 -1.16  -0.86  3166 1.00
    b_cafe[19]    -1.05    0.01  0.22 -1.38 -1.21 -1.09 -0.91  -0.55   363 1.01
    b_cafe[20]    -1.10    0.01  0.20 -1.43 -1.23 -1.12 -0.98  -0.64   613 1.01
    a_cafe[1]      4.08    0.00  0.18  3.74  3.97  4.08  4.20   4.44  5407 1.00
    a_cafe[2]      2.38    0.00  0.18  2.03  2.26  2.38  2.50   2.72  5091 1.00
    a_cafe[3]      3.94    0.00  0.18  3.60  3.82  3.94  4.06   4.30  6412 1.00
    a_cafe[4]      3.45    0.00  0.18  3.11  3.34  3.45  3.57   3.81  5699 1.00
    a_cafe[5]      2.14    0.00  0.18  1.79  2.02  2.14  2.26   2.50  5380 1.00
    a_cafe[6]      4.26    0.00  0.17  3.92  4.15  4.26  4.38   4.61  5192 1.00
    a_cafe[7]      3.56    0.00  0.18  3.21  3.44  3.56  3.68   3.91  5495 1.00
    a_cafe[8]      3.79    0.00  0.18  3.44  3.68  3.79  3.91   4.14  5661 1.00
    a_cafe[9]      3.89    0.00  0.18  3.53  3.77  3.89  4.01   4.23  4135 1.00
    a_cafe[10]     3.69    0.00  0.18  3.34  3.57  3.69  3.81   4.05  5761 1.00
    a_cafe[11]     2.47    0.00  0.19  2.11  2.35  2.48  2.60   2.84  1548 1.00
    a_cafe[12]     4.08    0.00  0.17  3.74  3.97  4.08  4.20   4.42  5712 1.00
    a_cafe[13]     3.88    0.00  0.18  3.52  3.75  3.87  4.00   4.24  4061 1.00
    a_cafe[14]     3.33    0.00  0.19  2.97  3.21  3.33  3.46   3.70  3082 1.00
    a_cafe[15]     4.23    0.01  0.20  3.85  4.09  4.22  4.36   4.65   471 1.01
    a_cafe[16]     3.60    0.00  0.17  3.25  3.48  3.60  3.71   3.93  5527 1.00
    a_cafe[17]     4.43    0.00  0.18  4.09  4.31  4.43  4.55   4.78  5089 1.00
    a_cafe[18]     6.10    0.00  0.19  5.73  5.97  6.09  6.22   6.46  4780 1.00
    a_cafe[19]     3.50    0.00  0.19  3.12  3.38  3.50  3.63   3.86  1800 1.00
    a_cafe[20]     3.90    0.00  0.18  3.53  3.78  3.90  4.03   4.25  3465 1.00
    a              3.73    0.00  0.21  3.32  3.60  3.73  3.87   4.16  7131 1.00
    b             -1.23    0.00  0.09 -1.40 -1.29 -1.23 -1.18  -1.06  2021 1.00
    sigma_cafe[1]  0.91    0.00  0.17  0.65  0.80  0.89  1.01   1.29  5579 1.00
    sigma_cafe[2]  0.21    0.01  0.12  0.01  0.12  0.20  0.29   0.46    72 1.05
    sigma          0.49    0.00  0.03  0.44  0.47  0.49  0.51   0.55  2271 1.00
    Rho[1,1]       1.00     NaN  0.00  1.00  1.00  1.00  1.00   1.00   NaN  NaN
    Rho[1,2]      -0.17    0.01  0.34 -0.75 -0.42 -0.20  0.06   0.57  3300 1.00
    Rho[2,1]      -0.17    0.01  0.34 -0.75 -0.42 -0.20  0.06   0.57  3300 1.00
    Rho[2,2]       1.00    0.00  0.00  1.00  1.00  1.00  1.00   1.00  5777 1.00
    lp__          62.41    3.30 17.59 41.97 52.03 58.04 66.26 118.46    28 1.12
```

## Appendix

### Appendix I
\tableinput{}{./code/output/data.csv}
