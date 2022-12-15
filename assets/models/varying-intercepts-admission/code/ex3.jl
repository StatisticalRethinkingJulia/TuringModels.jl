# This file was generated, do not modify it. # hide
chns = sample(
    m13_3(df.applications, df.dept_id, df.male, df.admit),
    NUTS(0.95),
    1000
)