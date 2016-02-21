using Convex
using SCS

function fit(model::Function, target::Array, args...; steps = 2)
    solver = SCSSolver(verbose=0)
    set_default_solver(solver);

    vars = [DiffVariable(a) for a in args]
    progr = [zeros(eltype(a),(length(a),steps+1)) for a in args]

    for j in 1:length(args)
        progr[j][:,1] = args[j][:]
    end
    for i = 1:steps
        problem = minimize(sumsquares(target - model(vars...)))
        solve!(problem)
        for j = eachindex(vars)
            vars[j].v += vars[j].dv.value
            progr[j][:,i+1] = vars[j].v[:]
        end
    end

    [v.v for v in vars], progr
end

export fit
