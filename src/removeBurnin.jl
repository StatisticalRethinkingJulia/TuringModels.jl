function removeBurnin(ch::Array{Turing.Utilities.Chain{AbstractRange{Int64}},1},
  Nadapt=0)
    nch = Turing.Utilities.Chain()
    Nchains = length(ch)
    v = ch[1].value
    dims = (size(v,1)-Nadapt,size(v,2),Nchains)
    nch.value = fill(0.0,dims)
    value2 = []
    rng = (Nadapt+1):size(v,1)
    for (i,c) in enumerate(ch)
        nch.value[:,:,i] = c.value[rng,:,:]
        push!(value2,c.value2[rng])
    end
    nch.value2 =reshape(vcat(value2...),dims[1],dims[3])
    nch.names = ch[1].names
    nch.range = 1:dims[1]
    nch.chains = 1:Nchains
    return nch
end