function flatten_name_map(chn::MCMCChains.AbstractChains)
  parms = values(chn.name_map)
  [String(parms[i][j]) for i in 1:length(parms) for j in 1:length(parms[i])]
end

function construct_a3d(chn::MCMCChains.AbstractChains)
  d, p, c = size(chn.value)
  a3d = fill(0.0, d, p, c);
  for (i, par) in enumerate(flatten_name_map(chn))
    a3d[:, i, 1] = reshape(chn[par], d)
  end
  a3d
end

function move_parameters_to_new_section(chn::MCMCChains.AbstractChains,
    new_section::Symbol, parameters_to_move::Vector{String})

  a3d = construct_a3d(chn)
  parms = values(chn.name_map.parameters)
  moved_parameters = String[]
  for par in parameters_to_move
    (par in parms) ? append!(moved_parameters, [par]) : @warn "$par not in $parms, ignored"
  end
  
  return MCMCChains.Chains(a3d,
    Symbol.(flatten_name_map(chn)),
    Dict(
      :parameters => Symbol.(filter(x -> !(x in parameters_to_move), parms)),
      new_section => Symbol.(moved_parameters),
      :internals => Symbol.(values(chn.name_map.internals))))
end
