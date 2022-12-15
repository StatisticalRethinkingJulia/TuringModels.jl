# This file was generated, do not modify it. # hide
chns = sample(
    m12_2(df.density, df.tank, df.surv),
    NUTS(),
    1000
)