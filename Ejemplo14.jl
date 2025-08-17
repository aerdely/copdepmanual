## Ejemplo 14: Rotaciones de una cópula arquimediana

using Plots, LaTeXStrings

c(u,v) = (1+θ) * u^(-θ-1) * v^(-θ-1) * (u^(-θ) + v^(-θ) - 1)^(-1/θ - 2)

begin
    θ = 2
    uu = range(0.05, 1, length = 100)
    vv = range(0.05, 1, length = 100)
    densidad = [c(u,v) for u ∈ uu, v ∈ vv]
    nivel = contour(uu, vv, transpose(densidad), xlabel = L"u", ylabel = L"v", 
                    title = L"c_{\theta}(u,v)",
                    fill = true, size = (500, 500)
    )
end
savefig("Ejemplo14A.pdf")

begin
    uu = range(0.05, 1, length = 100)
    vv = range(0.00, 0.95, length = 100)
    densidad = [c(u,1-v) for u ∈ uu, v ∈ vv]
    nivel = contour(uu, vv, transpose(densidad), xlabel = L"u", ylabel = L"v", 
                    title = L"V(c_{\theta})(u,v)=c_{\theta}(u,1-v)",
                    fill = true, size = (500, 500)
    )
end
savefig("Ejemplo14B.pdf")

begin
    uu = range(0.00, 0.95, length = 100)
    vv = range(0.00, 0.95, length = 100)
    densidad = [c(1-u,1-v) for u ∈ uu, v ∈ vv]
    nivel = contour(uu, vv, transpose(densidad), xlabel = L"u", ylabel = L"v", 
                    title = L"D(c_{\theta})(u,v)=c_{\theta}(1-u,1-v)",
                    fill = true, size = (500, 500)
    )
end
savefig("Ejemplo14C.pdf")

begin
    uu = range(0.00, 0.95, length = 100)
    vv = range(0.05, 1, length = 100)
    densidad = [c(1-u,v) for u ∈ uu, v ∈ vv]
    nivel = contour(uu, vv, transpose(densidad), xlabel = L"u", ylabel = L"v", 
                    title = L"H(c_{\theta})(u,v)=c_{\theta}(1-u,v)",
                    fill = true, size = (500, 500)
    )
end
savefig("Ejemplo14D.pdf")
