<!--This file was generated, do not modify it.-->
## Data

```julia:ex1
# Outcome and predictor almost perfectly associated.
x = repeat([-1], 9); append!(x, repeat([1],11));
y = repeat([0], 10); append!(y, repeat([1],10));
```

## Model

```julia:ex2
using Turing

@model function m_good_stan(x, y)
    α ~ Normal(0, 10)
    β ~ Normal(0, 10)

    logits = α .+ β * x

    y .~ BinomialLogit.(1, logits)
end;
```

## Output

```julia:ex3
chns = sample(m_good_stan(x, y), NUTS(), 1000)
```

\defaultoutput{}

## Original output

```julia:ex4
m_10_x,_results = "
    mean   sd   5.5% 94.5% n_eff Rhat
 a -5.09 4.08 -12.62 -0.25   100 1.00
 b  7.86 4.09   2.96 15.75   104 1.01
";
```

