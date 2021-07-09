module TuringModels

using CategoricalArrays
using DataFrames
using Gadfly

const project_root = pkgdir(TuringModels)

"""
    output_dir(name)

Return output directory for some model or script such as "africa".
This works around the OUTPUT macro from Franklin, because that macro doesn't work in Literate scripts.
"""
function output_dir(name)
    joinpath(project_root, "__site", "assets", "models", name, "code")
end

function write_gadfly_svg(output_dir, name, p; width=6inch, height=4inch)
    fig_path = joinpath(output_dir, "$name.svg")
    draw(SVG(fig_path, width, height), p)
end

function gadfly_plot(chns)
    df = DataFrame(chns)
    params = names(chns, :parameters)
    sdf = DataFrames.stack(df, params, variable_name=:parameter)
    sdf[!, :chain] = categorical(sdf.chain)

    p1 = plot(sdf, ygroup=:parameter, x=:iteration, y=:value, color=:chain,
        Geom.subplot_grid(Geom.line, free_x_axis=true, free_y_axis=true),
        Guide.ylabel("sample value"),
        # Key is shown on the right plot, so no need to show it twice.
        Theme(key_position=:none)
    )
    p2 = plot(sdf, ygroup=:parameter, x=:value, color=:chain,
        Geom.subplot_grid(Geom.density, free_x_axis=true, free_y_axis=true,
            Guide.xlabel(orientation=:horizontal)),
        Guide.ylabel("density"))

    hstack(p1, p2)
end

end # module
