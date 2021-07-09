# This file was generated, do not modify it. # hide
using Random

Random.seed!(1)
chns = sample(globe_toss(n, k), NUTS(), 1000)