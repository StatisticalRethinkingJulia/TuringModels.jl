# This file was generated, do not modify it. # hide
# hideall
output_dir = @OUTPUT
function write_svg(name, p)
  fig_path = joinpath(output_dir, "$name.svg")
  StatsPlots.savefig(fig_path)
end;