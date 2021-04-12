
# We define a simple Gaussian model with unknown mean and variance.

# \toc

# ## Model

using Turing

@model function gdemo(x, y)
  s ~ InverseGamma(2, 3)
  m ~ Normal(0, sqrt(s))
  x ~ Normal(m, sqrt(s))
  y ~ Normal(m, sqrt(s))
end;

# ## Output

# and run the sampler:

chns = sample(gdemo(1.5, 2), NUTS(), 1000)

# \defaultoutput{}
