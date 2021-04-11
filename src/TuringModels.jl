module TuringModels

using CategoricalArrays
using DataFrames
using Gadfly

const project_root = pkgdir(TuringModels)

function gadfly_plot(chns)

    df = DataFrame(chns)
    params = names(chns, :parameters)
    sdf = DataFrames.stack(df, params, variable_name=:parameter)
    sdf[!, :chain] = categorical(sdf.chain)

    p1 = plot(sdf, ygroup=:parameter, x=:iteration, y=:value, color=:chain,
        Geom.subplot_grid(Geom.line, free_x_axis=true, free_y_axis=true),
        Guide.ylabel("sample value"),
        # Key is also shown on the right plot.
        Theme(key_position=:none)
    )
    p2 = plot(sdf, ygroup=:parameter, x=:value, color=:chain,
        Geom.subplot_grid(Geom.density, free_x_axis=true, free_y_axis=true,
            Guide.xlabel(orientation=:horizontal)),
        Guide.ylabel("density"))

    hstack(p1, p2)
end

end # module
