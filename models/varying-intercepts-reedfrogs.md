+++
title = "Varying intercepts Reedfrogs"
showall = true
+++

On page 402 of Edition 2, this model is defined as

$$
\begin{aligned}
  S_i &\sim \text{Binomial}(N_i, p_i) \\
  \text{logit}(p_i) &= \alpha_\text{TANK}[i] \\
  \alpha_\text{TANK}[i] &\sim \text{Normal}(0, 1.5)
\end{aligned}
$$

\toc

\literate{/scripts/varying-intercepts-reedfrogs.jl}
