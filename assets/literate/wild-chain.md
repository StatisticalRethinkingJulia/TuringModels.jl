<!--This file was generated, do not modify it.-->
## Data

```julia:ex1
y = [-1, 1]
```

## Model

```julia:ex2
import Random

using Turing

Random.seed!(1)

@model function m8_2(y)
    α ~ Flat() ## improper prior with pobability one everywhere
    σ ~ FlatPos(0.0) ## improper prior with probability one everywhere above 0.0

    y ~ Normal(α, σ)
end;
```

## Output

```julia:ex3
chns = sample(m8_2(y), NUTS(), 1000)
```

\defaultoutput{}

