module TuringModels

using CategoricalArrays
using DataFrames

const project_root = string(pkgdir(TuringModels))::String

"""
    output_dir(name)

Return output directory for some model or script such as "africa".
This works around the OUTPUT macro from Franklin, because that macro doesn't work in Literate scripts.
"""
function output_dir(name)
    joinpath(project_root, "__site", "assets", "models", name, "code")
end

end # module
