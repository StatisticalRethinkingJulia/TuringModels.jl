# This file was generated, do not modify it. # hide
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