<!--This file was generated, do not modify it.-->
## Data

```julia:ex1
import CSV
import Random
import TuringModels

using DataFrames
using Statistics: mean

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "Kline.csv")
df = CSV.read(data_path, DataFrame; delim=';')

df.log_pop = log.(df.population)
df.contact_high = [contact == "high" ? 1 : 0 for contact in df.contact]
```

New col where we center(!) the log_pop values

```julia:ex2
mean_log_pop = mean(df.log_pop)
df.log_pop_c = map(x -> x - mean_log_pop, df.log_pop)
df
```

## Model

```julia:ex3
using Turing

@model m10_10stan_c(total_tools, log_pop_c, contact_high) = begin
    α ~ Normal(0, 100)
    βp ~ Normal(0, 1)
    βc ~ Normal(0, 1)
    βpc ~ Normal(0, 1)

    for i ∈ 1:length(total_tools)
        λ = exp(α + βp*log_pop_c[i] + βc*contact_high[i] +
            βpc*contact_high[i]*log_pop_c[i])
        total_tools[i] ~ Poisson(λ)
    end
end;

chns = sample(
    m10_10stan_c(df.total_tools, df.log_pop_c, df.contact_high),
    NUTS(),
    1000
)
```

\defaultoutput{}

## Original output

```julia:ex4
m_10_10t_c_result = "
    mean   sd  5.5% 94.5% n_eff Rhat
 a   3.31 0.09  3.17  3.45  3671    1
 bp  0.26 0.03  0.21  0.32  5052    1
 bc  0.28 0.12  0.10  0.47  3383    1
 bcp 0.07 0.17 -0.20  0.34  4683    1
";
```

