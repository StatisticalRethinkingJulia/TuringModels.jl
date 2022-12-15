# This file was generated, do not modify it. # hide
n = nrow(df)
model = reedfrogs(df.density, df.tank_index, df.surv)
chns = sample(model, NUTS(), 1000)