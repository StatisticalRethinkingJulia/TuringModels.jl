module TuringModels

using Reexport 

@reexport using SR, Turing

using DataStructures
import SR: scriptentry

const src_path_t = @__DIR__

"""

# rel_path_t

Relative path using the TuringModels src/ directory. Copied from
[DynamicHMCExamples.jl](https://github.com/tpapp/DynamicHMCExamples.jl)

### Example to get access to the data subdirectory
```julia
rel_path_t("..", "data")
```
"""
rel_path_t(parts...) = normpath(joinpath(src_path_t, parts...))

include("scriptentry_t.jl")
include("generate_t.jl")

export
  rel_path_t,
  script_dict_t,
  generate_t

end # module
