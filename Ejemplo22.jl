## Ejemplo 22: Π ≤ C ≤ M

using Plots, LaTeXStrings, HCubature, Distributions

C(u,v,θ) = (u^(-θ) + v^(-θ) - 1)^(-1/θ)

function simulaCopula(θ, n) # Del Ejemplo 15
    u = rand(Uniform(0, 1), n)
    ψ(t,u,θ) = (1 - (u^(-θ))*(1 - t^(-θ/(1+θ))))^(-1/θ)
    t = rand(Uniform(0, 1), n)
    v = zeros(n)
    for j ∈ 1:n
        v[j] = ψ(t[j], u[j], θ)
    end
    return u, v
end

function Schweizer(θ)
    f(z) = C(z[1], z[2], θ) - z[1] * z[2]
    result = hcubature(f, [0, 0], [1, 1]) #, rtol=1e-6, atol=1e-6)
    return 12*result[1]
end

Schweizer(0.1)
Schweizer(1.1)
Schweizer(24)

n = 3000

# Simula con θ = 0.1
θ = 0.1
u, v = simulaCopula(θ, n)
begin
    scatter(u, v, mc = :black, ms = 1, legend = false, size = (400,400))
    xlabel!(L"u", fontsize = 20)
    ylabel!(L"v", fontsize = 20)
    xticks!([0, 0.5, 1])
    yticks!([0, 0.5, 1])
end
savefig("Ejemplo22A.pdf")

# Simula con θ = 1.1
θ = 1.1
u, v = simulaCopula(θ, n)
begin
    scatter(u, v, mc = :black, ms = 1, legend = false, size = (400,400))
    xlabel!(L"u", fontsize = 20)
    ylabel!(L"v", fontsize = 20)
    xticks!([0, 0.5, 1])
    yticks!([0, 0.5, 1])
end
savefig("Ejemplo22B.pdf")

# Simula con θ = 24
θ = 24
u, v = simulaCopula(θ, n)
begin
    scatter(u, v, mc = :black, ms = 1, legend = false, size = (400,400))
    xlabel!(L"u", fontsize = 20)
    ylabel!(L"v", fontsize = 20)
    xticks!([0, 0.5, 1])
    yticks!([0, 0.5, 1])
end
savefig("Ejemplo22C.pdf")

# Gráfica de Schweizer
θ = collect(range(0.01, 25, length = 1000))
S = Schweizer.(θ)
begin
    plot(θ, S, lw = 3, color = :cyan3, legend = false, size = (400, 400))
    xticks!([0, 5, 10, 15, 20, 25])
    xlabel!(L"\theta", fontsize = 20)
    ylabel!(L"\mu_{C_{θ}}", fontsize = 20)
end
savefig("Ejemplo22D.pdf")

