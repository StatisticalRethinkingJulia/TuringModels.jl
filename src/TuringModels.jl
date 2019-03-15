module TuringModels

using Reexport 

@reexport using StatisticalRethinking, Turing, Flux

using DataStructures

const src_path_t = @__DIR__

"""

# rel_path_t

Relative path using the TuringModels src/ directory.

### Example to get access to the data subdirectory
```julia
rel_path_t("..", "data")
```
"""
rel_path_t(parts...) = normpath(joinpath(src_path_t, parts...))

include("scriptentry_t.jl")
include("generate_t.jl")
include("maximum_a_posteriori.jl")

export
  rel_path_t,
  script_dict_t,
  generate_t,
  maximum_a_posteriori

end # module
