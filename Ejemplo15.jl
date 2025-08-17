## Ejemplo 15: Simulando con cópula arquimediana

using Plots, LaTeXStrings, Distributions



function simulaCopula(θ, n)
    u = rand(Uniform(0, 1), n)
    ψ(t,u,θ) = (1 - (u^(-θ))*(1 - t^(-θ/(1+θ))))^(-1/θ)
    t = rand(Uniform(0, 1), n)
    v = zeros(n)
    for j ∈ 1:n
        v[j] = ψ(t[j], u[j], θ)
    end
    return u, v
end

U, V = simulaCopula(2, 4_000)

scatter(U, V, xlabel = L"U", ylabel = L"V", legend = false, size = (500, 500), markersize = 0.5)
savefig("Ejemplo15A.pdf")

X = quantile(Beta(1/2, 1/2), U)
Y = quantile(Beta(1/3, 2/3), V)
scatter(X, Y, xlabel = L"X", ylabel = L"Y", legend = false, size = (500, 500), markersize = 0.5)
savefig("Ejemplo15B.pdf")   

S = quantile(Normal(0, 1), U)
T = quantile(Normal(0, 1), V)
scatter(S, T, xlabel = L"S", ylabel = L"T", legend = false, size = (500, 500), markersize = 0.5)
savefig("Ejemplo15C.pdf")

