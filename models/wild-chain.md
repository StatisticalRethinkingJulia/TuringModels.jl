+++
title = "Wild chain"
+++

This model shows what happens if you use extremely flat priors, and is fixed in [Weakly Informative Priors](/models/weakly-informative-priors).

\toc

## Data 

```julia:data
y = [-1, 1]
```

## Model
```julia:model
using Turing

@model m8_2(y) = begin
    σ ~ FlatPos(0.0) # improper prior with probability one everywhere above 0.0
    α ~ Flat() # improper prior with pobability one everywhere

    y .~ Normal(α, σ)
end

chains = sample(m8_2(y), NUTS(0.65), 1000)
```

## Output

\defaultoutput{}
