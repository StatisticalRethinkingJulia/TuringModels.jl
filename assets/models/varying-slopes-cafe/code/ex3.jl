# This file was generated, do not modify it. # hide
chns = sample(
    m13_1(df.cafe, df.afternoon, df.wait),
    # This model fails on NUTS(0.65).
    Turing.NUTS(0.95),
    1000
)