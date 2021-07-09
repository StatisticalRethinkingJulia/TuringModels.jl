# This file was generated, do not modify it. # hide
function data2df(time, hare, lynx; index=1)
    df = DataFrame(
        time = time,
        hare = hare,
        lynx = lynx
    )
    sdf = stack(df, [:hare, :lynx]; variable_name=:group, value_name=:number)
    sdf[!, :index] .= index
    sdf
end

timesteps = 1:length(sol)
time = sol.t[timesteps]
hare = sol[1, timesteps]
lynx = sol[2, timesteps]

df_original = data2df(time, hare, lynx)
write_gadfly_svg("data", # hide
plot(df_original, x=:time, y=:number, color=:group,
    Geom.point, Geom.smooth(method=:loess, smoothing=0.2))
) # hide
nothing # hide