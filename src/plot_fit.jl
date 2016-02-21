using PyPlot

function plot_fit(progr)
    m = length(progr)
    b = 0
    for j in eachindex(progr)
        n = size(progr[j],1)
        for i = 1:n
            subplot(m,n,b + i)
            plot(progr[j][i,:]', ".-")
        end
        b += n
    end
    tight_layout()
end

export plot_fit
