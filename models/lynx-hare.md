+++
title = "Lynx and hare populations"
showall = true
reeval = true
+++


The last model in the 2nd edition of the Statistical Rethinking book is a time series model of hare and lynx populations.
The model below is based on the book and the [Turing.jl tutorials](https://turing.ml).
The main differences with the Turing tutorial are that below we use Gadfly for plotting and that the Turing tutorial has more explanation.

In the book, the model, `m16.5`, is defined around page 547 as

$$
\begin{aligned}
  \sigma_H &\sim \text{Exponential}(1) & \text{[Prior for measurement dispersion]} \\
  \sigma_L &\sim \text{Exponential}(1) & \text{[Prior for measurement dispersion]} \\
  p_H &\sim \text{Beta}(\alpha_H, \beta_H) & \text{[Prior for hare trap probability]} \\
  p_L &\sim \text{Beta}(\alpha_L, \beta_L) & \text{[Prior for lynx trap probability]} \\
  b_H &\sim \text{Half-Normal}(1, 0.5) & \text{[Prior hare birth rate]} \\
  b_L &\sim \text{Half-Normal}(0.05, 0.05) & \text{[Prior lynx birth rate]} \\
  m_H &\sim \text{Half-Normal}(0.05, 0.05) & \text{[Prior hare mortality rate]} \\
  m_L &\sim \text{Half-Normal}(1, 0.05) & \text{[Prior lynx mortality rate]}
\end{aligned}
$$

\literate{/scripts/lynx-hare.jl}
