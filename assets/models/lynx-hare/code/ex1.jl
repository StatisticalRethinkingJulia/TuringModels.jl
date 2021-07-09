# This file was generated, do not modify it. # hide
# hideall

import Random

using TuringModels

Random.seed!(1)

output_dir = TuringModels.output_dir("lynx-hare") # hide
mkpath(output_dir)

function write_gadfly_svg(name, p; width=6inch, height=4inch)
    TuringModels.write_gadfly_svg(output_dir, name, p; width, height)
end
nothing