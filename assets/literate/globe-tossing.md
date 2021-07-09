<!--This file was generated, do not modify it.-->
## Data

```julia:ex1
import Random

Random.seed!(1)

n = 9
k = 6;
```

## Model

```julia:ex2
using Turing

@model function globe_toss(n, k)
    θ ~ Beta(1, 1)
    k ~ Binomial(n, θ)
    return k, θ
end;
```

## Output

```julia:ex3
using Random

Random.seed!(1)
chns = sample(globe_toss(n, k), NUTS(), 1000)
```

\defaultoutput{}

