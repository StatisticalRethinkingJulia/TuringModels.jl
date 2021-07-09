# This file was generated, do not modify it. # hide
sol_noise = solve(prob1, Tsit5(); saveat=0.1)
odedata = Array(sol_noise) + 0.8 * randn(size(Array(sol_noise)))

time = sol_noise.t[timesteps]
hare = odedata[1, :]
lynx = odedata[2, :]
df_noise = data2df(time, hare, lynx)

write_gadfly_svg("data_noise", # hide
plot(df_noise, x=:time, y=:number, color=:group,
    Geom.point, Geom.smooth(method=:loess, smoothing=0.2))
) # hide
nothing # hide