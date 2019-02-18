```@meta
CurrentModule = TuringModels
```

## `rel_path_t`
```@docs
rel_path_t(parts...)
```

## `generate_t`
```@docs
generate_t(; sd=script_dict_t)
generate_t(chapter::AbstractString; sd=script_dict_t_)
generate_t(chapter::AbstractString, scriptfile::AbstractString; sd=script_dict_t_)
```

## `ScriptEntry`
```@docs
ScriptEntry
```

## `scriptentry`
```@docs
scriptentry(scriptfile; nb = true, exe = true, doc = true)
```

## `maximum_a_posteriori`
```@docs
maximum_a_posteriori(model, lower_bound, upper_bound)
```

- link to [m2.1t.jl](@ref)
- link to [`maximum_a_posteriori(model, lower_bound, upper_bound)`](@ref)
