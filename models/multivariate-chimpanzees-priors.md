+++
title = "Multivariate Chimpanzees priors"
showall = true
+++

This is `m13.6` in Rethinking 1st Edition.
In the 2nd Edition, the most similar one appears to be `m13.4nc`.

This model is not ran when generating these pages because the running time is about 20 minutes.
You can run it locally and inspect the output by downloading the file and running
```
julia -i multivariate-chimpanzees.priors.jl
```

The file contains

```julia:code
# hideall
import TuringModels

code_path = joinpath(TuringModels.project_root, "scripts", "multivariate-chimpanzees-priors.jl")
text = read(code_path, String)
print(text)
```
\output{code}
