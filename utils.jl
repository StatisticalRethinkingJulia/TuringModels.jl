function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

function lx_defaultoutput(com, _)
    raw"""
    ```julia:write_helper
    # hideall
    output_dir = @OUTPUT
    function write_svg(name, p)
      fig_path = joinpath(output_dir, "$name.svg")
      StatsPlots.savefig(fig_path)
    end;
    ```
    \output{write_helper}

    ```julia:plot
    using StatsPlots

    write_svg("chns", # hide
    StatsPlots.plot(chns)
    ) # hide
    ```
    \output{plot}
    \fig{chns.svg}
    """
end

"""
    \\defaultgadflyoutput{}

Plot `chns` via Gadfly.
Don't combine this with a call to StatsPlots or `\\defaultoutput` to avoid conflict errors.
"""
function lx_defaultgadflyoutput(com, _)
    raw"""
    ```julia:write_helper
    # hideall
    using DataFrames
    using Gadfly
    using TuringModels

    output_dir = @OUTPUT
    function write_svg(name, p, width, height)
      fig_path = joinpath(output_dir, "$name.svg")
      draw(SVG(fig_path, width, height), p)
    end;

    df = DataFrame(chns)
    params = names(chns, :parameters)
    width = 8inch
    height = length(params) * 2inch
    nothing
    ```
    \output{write_helper}

    ```julia:plot

    write_svg("chns", # hide
    TuringModels.gadfly_plot(chns)
    , width, height) # hide
    nothing # hide
    ```
    \output{plot}
    \fig{chns.svg}
    """
end
