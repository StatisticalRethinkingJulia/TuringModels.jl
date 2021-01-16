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

    write_svg("chains", # hide
    StatsPlots.plot(chains)
    ) # hide
    ```
    \output{plot}
    \fig{chains.svg}
    """
end
