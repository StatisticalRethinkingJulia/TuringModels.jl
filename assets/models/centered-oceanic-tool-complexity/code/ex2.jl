# This file was generated, do not modify it. # hide
mean_log_pop = mean(df.log_pop)
df.log_pop_c = map(x -> x - mean_log_pop, df.log_pop)
df