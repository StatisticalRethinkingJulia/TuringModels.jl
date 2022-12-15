# This file was generated, do not modify it. # hide
chns = sample(
    m12_6(df.total_tools, df.log_pop, df.society),
    NUTS(0.95),
    1000
)