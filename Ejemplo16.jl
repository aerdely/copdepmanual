## Ejemplo 16: Rotando, mezclando y pegando cópulas

using Plots, LaTeXStrings, Distributions


# simulador de cópula

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


# rotaciones 

n = 4_000
U, V = simulaCopula(2, n)
DC = (1 .- U, 1 .- V)
U, V = simulaCopula(2, n)
VC = (U, 1 .- V)

scatter(DC[1], DC[2], xlabel = L"U_1\,=\,1-U", ylabel = L"V_1\,=\,1-V", legend = false, size = (500, 500), markersize = 0.5)
savefig("Ejemplo16A.pdf")

scatter(VC[1], VC[2], xlabel = L"U_2\,=\,U", ylabel = L"V_2\,=\,1-V", legend = false, size = (500, 500), markersize = 0.5)
savefig("Ejemplo16B.pdf")


# combinación lineal convexa 

α = 0.3
B = rand(Bernoulli(α), n)
Uconvx = B .* DC[1] .+ (1 .- B) .* VC[1]
Vconvx = B .* DC[2] .+ (1 .- B) .* VC[2]
scatter(Uconvx, Vconvx, xlabel = L"BU_1+(1-B)U_2", ylabel = L"BV_1+(1-B)V_2", legend = false, size = (500, 500), markersize = 0.5)
savefig("Ejemplo16C.pdf")


# pegado de cópulas

θ = 0.3
B = rand(Bernoulli(θ), n)
Uglu = B .* (θ .* DC[1]) .+ (1 .- B) .* (θ .+ (1-θ) .* VC[1])
Vglu = B .* DC[2] .+ (1 .- B) .* VC[2]
scatter(Uglu, Vglu, xlabel = L"B(0.3U_1)+(1-B)(0.3+(1-0.3)U_2)", ylabel = L"BV_1+(1-B)V_2", legend = false, size = (500, 500), markersize = 0.5)
xticks!([0,θ,1])
vline!([θ], lw = 1, ls = :dash, color = :black)
savefig("Ejemplo16D.pdf")
