+++
title = "Glimmer"
showall = true
+++

In Statistical Rethinking Edition 1, McElreath shows that the R `glimmer` package introduces weakly regularizing priors by default.
This can sometimes lead to nonsense estimates.
To fix it, McElreath uses a very weakly informative prior in model `m.good`.

\literate{/scripts/glimmer.jl}
