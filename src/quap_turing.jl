# Everything is experimental! If you want to use it, you need to import it yourself.
# If you find problems, please open an issue.

using Optim
using Turing
using StatsBase
using LinearAlgebra

#      Run like
# using Turing
# @model height(heights) = begin
#     μ ~ Normal(178, 20)
#     σ ~ Uniform(0, 50)
#     heights .~ Normal(μ, σ)
# end
# m = height(d2.height)
# res = quap(m)

# Find the MAP via optimization and get the information matrix at that point.
# Look if your solution converged. Sometimes even solutions that didn't converge
# might be pretty good, on the other hand, just because the solver converged that
# doesn't mean you got the point you are looking for; this isn't even global
# optimization. In any case, trying other optimization methods might help.
function quap(model::Turing.Model, args...; kwargs...)
    opt = optimize(model, MAP(), args...; kwargs...)

    coef = opt.values.array
    var_cov_matrix = informationmatrix(opt)
    sym_var_cov_matrix = Symmetric(var_cov_matrix)  # lest MvNormal complains, loudly
    converged = Optim.converged(opt.optim_result)

    distr = if length(coef) == 1
        Normal(coef[1], √sym_var_cov_matrix[1])  # Normal expects stddev
    else
        MvNormal(coef, sym_var_cov_matrix)       # MvNormal expects variance matrix
    end

    (coef = coef, vcov = sym_var_cov_matrix, converged = converged, distr = distr)
end
