+++
title = "Gaussian model of height"
showall = true
+++

This model is based on data of the !Kung San people \citep{pHowell2010}.
The prior assumes that the height of a man is most likely to be 178 cm because McElreath has that lenght.

In Edition 2, McElreath defines the model as

$$
  \begin{aligned}
    h_i &\sim \text{Normal}(\mu, \sigma) \\
    \mu &\sim \text{Normal}(178, 0.1) \\
    \sigma &\sim \text{Uniform}(0, 50)
  \end{aligned}
$$

\toc 

\literate{/scripts/height.jl}

## References

\biblabel{pHowell2010}{Howell, 2010}
Howell, N. (2010).
Life Histories of the Dobe !Kung: Food, Fatness, and Well-being over the Life-span.
Origins of Human Behavior and Culture. 
University of California Press
