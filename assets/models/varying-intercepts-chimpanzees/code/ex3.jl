# This file was generated, do not modify it. # hide
chns = sample(
    m12_4(df.pulled_left, df.actor, df.condition, df.prosoc_left),
    NUTS(),
    1000
)