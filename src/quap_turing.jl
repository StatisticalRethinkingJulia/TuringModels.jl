# Everything is very experimental! If you want to use it, you need to import it yourself.
# If you find problems, please open an issue.

using Optim, NLSolversBase
using DynamicPPL
using LinearAlgebra

# Get the NLL function from a Turing model. Taken from:
# https://turing.ml/dev/docs/using-turing/advanced#maximum-a-posteriori-estimation
function get_nlogp(model)
    # Construct a trace struct
    vi = Turing.VarInfo(model)

    # Define a function to optimize.
    function nlogp(sm)
        spl = Turing.SampleFromPrior()
        new_vi = Turing.VarInfo(vi, spl, sm)
        model(new_vi, spl)
        -Turing.getlogp(new_vi)
    end

    return nlogp
end


#      Run like
# using Turing
# @model height(heights) = begin
#     μ ~ Normal(178, 20)
#     σ ~ Uniform(0, 50)
#     heights .~ Normal(μ, σ)
#     return μ, σ                   <-- you need this line or you need to provide a
#                                       start point
# end
# m = height(d2.height)
# res = quap(m)
# MvNormal(res.coef, res.vcov)

# To find a good starting point, try to sample from the prior
function quap(model::DynamicPPL.Model; method = SimulatedAnnealing())
    # Find out if sampling from the prior is possible.
    # Something like `return μ` or `return μ, σ` will give you a Number or a Tuple,
    # while leaving it out will return the data, usually an Array. This isn't
    # bullet-proof (e.g. you can pass a single number as data) but I don't have
    # anything more sophisticated right now.
    testprior = typeof(m())
    if !(testprior <: Number || testprior <: Tuple)
        error("Your model must either include a return statement to sample from the prior or you must provide a start point: `quap(model, start; method)`")
    end

    priors = [[m()...] for _ in 1:100]  # Tuples -> Arrays
    start = median(hcat(priors...), dims = 2)
    start = [start...]  # 2x1 Matrix -> Vector

    quap(model, start; method = method)
end

# Find the MAP via optimization and take the hessian at that point.
# During a bit of simple testing SimulatedAnnealing did the best job getting close
# to the minimum while NelderMead while good at finishing the job. So if
# SimulatedAnnealing didn't converge or your supplied method errors, try again
# with NelderMead (or BFGS in the 1D case).
# Look if your solution converged. Sometimes even solutions that didn't converge
# might be pretty good, on the other hand, just because the solver converged that
# doesn't mean you got the point you are looking for; this isn't even global
# optimization. In any case, trying other methods or starting points might help.
# Adapted from:
# https://julianlsolvers.github.io/Optim.jl/stable/#examples/generated/maxlikenlm/
function quap(model::DynamicPPL.Model, start; method = SimulatedAnnealing())
    nlogp = get_nlogp(model)
    func = TwiceDifferentiable(vars -> nlogp(vars), start; autodiff = :forward)

    converged = true
    MAP = start

    methods = [
        method,
        length(start) == 1 ? BFGS() : NelderMead(),  # NelderMead doesn't work in 1D
    ]
    for method in methods
        try
            opt = optimize(func, start, method)
            MAP = Optim.minimizer(opt)
            converged = Optim.converged(opt)
        catch
            converged = false
        end
        converged && break
    end

    numerical_hessian = hessian!(func, MAP)
    var_cov_matrix = inv(numerical_hessian)
    sym_var_cov_matrix = Symmetric(var_cov_matrix)  # lest MvNormal complains, loudly

    (coef = MAP, vcov = sym_var_cov_matrix, converged = converged)
end
