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
  existing_pars = values(chn.name_map.parameters)
  internal_pars = values(chn.name_map.internals)
  moved_pars = String[]
  for par in parameters_to_move
    if par in existing_pars
      append!(moved_pars, [par]) 
    else
      @warn "$par not in $parms, ignored"
    end
  end
  remaining_pars = filter(x -> !(x in parameters_to_move), existing_parmeterss)
  
  println(remaining_variables)
  
  return MCMCChains.Chains(a3d,
    Symbol.(flatten_name_map(chn)),
    Dict(
      :parameters => Symbol.(remaining_pars),
      new_section => Symbol.(moved_pars),
      :internals => Symbol.(internal_pars)))
end
