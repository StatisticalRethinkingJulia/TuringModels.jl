+++
title = "Varying slopes cafes"
+++

On page 441 of Statistical Rethinking Edition 2 (2020), `m14.1` is defined as

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

\literate{/scripts/varying-slopes-cafe.jl}
