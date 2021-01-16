+++
title = "Beta-binomial"
showall = true
+++

This beta-binomial model is `m11.5` in Statistical Rethinking 1st Edition.
In Statistical Rethinking 2nd Edition it is `m12.1` and defined as 

$$
\begin{aligned}
  A_i &\sim \text{BetaBinomial}(N_i, \overline{p}_i, \theta) \\
  \text{logit}(\overline{p}_i) &= \alpha_{\text{GID}[i]} \\
  \alpha_j &\sim \text{Normal}(0, 1.5) \\
  \theta &= \phi + 2 \\
  \phi &\sim \text{Exponential(1)}
\end{aligned}
$$

\toc 

\literate{/scripts/beta-binomial.jl}

