# This file was generated, do not modify it. # hide
function posterior_sol(index)
    posterior_p_subset = Array(chns)[rand(1:1500), 1:4]
    prob = remake(prob1; p=posterior_p_subset)
    retro_sol = solve(prob, Tsit5(); saveat=0.1)
    timesteps = 1:length(retro_sol)

    time = retro_sol.t[timesteps]
    hare = retro_sol[1, timesteps]
    lynx = retro_sol[2, timesteps]
    data2df(time, hare, lynx; index)
end

samples = 1:100
dfs = posterior_sol.(samples)
df_retro = vcat(dfs...)

df_retro.index = categorical(df_retro.index)
hare_samples = filter(:group => ==("hare"), df_retro)
lynx_samples = filter(:group => ==("lynx"), df_retro)

write_gadfly_svg("retrofitted", # hide
plot(
    layer(hare_samples, x=:time, y=:number, color=:index,
        Geom.smooth(method=:loess, smoothing=0.2),
        Theme(; line_width=0.1mm, alphas=[0.3])
    ),
    layer(lynx_samples, x=:time, y=:number, color=:index,
        Geom.smooth(method=:loess, smoothing=0.2),
        Theme(; line_width=0.1mm, alphas=[0.3])
    ),
    layer(df_original, x=:time, y=:number, color=:group,
        Geom.point, Geom.smooth(method=:loess, smoothing=0.2)
    ),
    Theme(; key_position=:none)
)
) # hide
nothing # hide