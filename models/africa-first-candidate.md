+++
title = "Africa first candidate model"
showall = true
+++

In Edition 2 on page 244, McElreath defines the model as

$$
  \begin{aligned}
    \log(y_i) &\sim \text{Normal}(\mu_i, \sigma) \\
    \mu_i &= \alpha + \beta(r_i - \overline{r}) \\
    \alpha &\sim \text{Normal}(1, 1) \\
    \beta &\sim \text{Normal}(0, 1) \\
    \sigma &\sim \text{Exponential}(1)
  \end{aligned}
$$

To define this in Turing.jl, we change it to

$$
  \begin{aligned}
    \sigma &\sim \text{Exponential(1)} \\
    \alpha &\sim \text{Normal}(1, 0.1) \\
    \beta &\sim \text{Normal}(0, 0.3) \\
    \mu_i &= \alpha + \beta(r_i - \overline{r}) \\
    y_i &\sim \text{LogitNormal}(\mu_i, \sigma)
  \end{aligned}
$$

where $y_i$ is the GDPs for nation $i$, $r_i$ is terrain ruggedness for nation $i$ and $\overline{r}$ is the mean of the ruggedness in the whole sample.

McElreath calls two models `m8.1`.
We have tried to get close to the `precis` output on page 245, but both `m8.1` seem to give a different output for $\sigma$.
For `\sigma` and `\beta`, our results on this page correspond to the resutls by McElreath.

\literate{/scripts/africa-first-candidate.jl}

## Original output

From page 245:

 | mean | sd | 5.5% | 94.5%
--- | --- | --- | --- | ---
α | 1.00 | 0.01 | 0.98 | 1.02
β | 0.00 | 0.05 | -0.09 | 0.09
σ | 0.14 | 0.01 | 0.12 | 0.15
