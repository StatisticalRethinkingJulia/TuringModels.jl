+++
title = "Partial-pooling estimates"
showall = true
+++

In model `m12.3` in Statistical Rethinking Edition 1, representative values for the tadpole data are generated.

The multilevel binomial model is defined as 

$$
\begin{aligned}
  s_i &\sim \text{Binomial}(n_i, \overline{p}_i) \\
  \text{logit}(p_i) &= \alpha_{\text{POND}[i]} \\
  \alpha_{\text{POND}} &\sim \text{Normal}(0, \sigma) \\
  \alpha &= \text{Normal}(0, 1) \\
  \sigma &\sim \text{HalfCauchy}(1)
\end{aligned}
$$

\toc

\literate{/scripts/partial-pooling-estimates.jl}
