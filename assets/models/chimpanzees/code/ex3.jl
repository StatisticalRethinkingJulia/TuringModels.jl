# This file was generated, do not modify it. # hide
model = m10_3(df.pulled_left, df.condition, df.prosoc_left)
chns = sample(model, NUTS(), 2000)