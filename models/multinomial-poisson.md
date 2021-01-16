+++
title = "Multinomial Poisson regression"
showall = true
+++

On page 399 of McElreath (2015), `m13.2` is defined as

$$
\begin{aligned}
  A_i &\sim \text{Binomial}(n_i, p_i) \\
  \text{logit}(p_i) &= \alpha_\text{dept}[i] + \beta m_i \\
  \alpha_\text{dept} &\sim \text{Normal}(\alpha, \sigma) \\
  \alpha &\sim \text{Normal}(0, 10) \\
  \beta &\sim \text{Normal}(0, 1) \\
  \sigma &\sim \text{HalfCauchy}(0, 2)
\end{aligned}
$$

\toc

\literate{/scripts/multinomial-poisson.jl}
