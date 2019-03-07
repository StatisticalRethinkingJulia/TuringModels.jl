function combine_chains(chainArray::Array{<:Chains,1})
    ch = chainArray[1]
    d, p, c = size(ch.value)
    c = length(chainArray)
    value = Array{Union{Missing,Real}}(undef, d, p, c)
    for (i,c) in enumerate(chainArray)
        value[:,:,i] = construct_a3d(c)
    end
    MCMCChains.Chains(value,
      Symbol.(flatten_name_map(ch)),
      Dict(
        :parameters => Symbol.(values(ch.name_map.parameters)),
        :internals => Symbol.(values(ch.name_map.internals))))
end


