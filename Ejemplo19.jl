## Ejemplo 19: Método ABC

using Plots, LaTeXStrings, Distributions

function simulaCopula(θ, n)
    u = rand(Uniform(0, 1), n)
    ψ(t,u,θ) = (1 - (u^(-θ))*(1 - t^(-θ/(1+θ))))^(-1/θ)
    t = rand(Uniform(0, 1), n)
    v = zeros(n)
    for j ∈ 1:n
        v[j] = ψ(t[j], u[j], θ)
    end
    return u, 1 .- v
end

begin
    θ = 1
    n = 4_000
    U, V = simulaCopula(θ, n)
    scatter(U, V, xlabel = L"U", ylabel = L"V", legend = false, size = (500, 500), markersize = 0.5)
end
savefig("Ejemplo19A.pdf")

begin
    C(u,v,θ) = u - (u^(-θ) + (1-v)^(-θ) - 1)^(-1/θ)
    c(u,v,θ) = (1+θ) * (u^(-θ) + (1-v)^(-θ))^(-1/θ-2) * (u^(-θ-1) * (1-v)^(-θ-1))
    logc(u,v,θ) = log(1+θ) - (1+θ)*(log(u) + log(1-v)) - (1/θ + 2) * log(u^(-θ) + (1-v)^(-θ)-1)
    Cn(u,v) = (1/n) * sum( (U .≤ u) .* (V .≤ v) )
end;

function L(θ)
    valor = 0.0
    for i ∈ 1:n 
        valor += logc(U[i], V[i], θ)
    end
    return valor 
end

begin
    th = range(0.01, 2.5, length = 1_000)
    Lth = [L(θ) for θ in th]
    k = findmax(Lth)[2]
    plot(th, Lth, xlabel = L"θ", ylabel = L"\log\,L(θ\,\,|D)",
         label = "", size = (500, 500), lw = 3
    )
    θmv = th[k]
    vline!([θmv], color = :red, label = "θ* = $(round(θmv, digits = 3))")
end
savefig("Ejemplo19B.pdf")

function h(θ) 
    valor = 0.0
    for i ∈ 1:n
        valor += (C(U[i],V[i],θ) - Cn(U[i],V[i]))^2
    end
    return valor
end

begin
    th = range(0.01, 2.5, length = 1_000)
    hth = [h(θ) for θ in th]
    k = findmin(hth)[2]
    plot(th, hth, xlabel = L"θ", ylabel = L"h(θ\,\,|D)",
         label = "", size = (500, 500), lw = 3
    )
    θh = th[k]
    vline!([θh], color = :red, label = "θ* = $(round(θh, digits = 3))")
end
savefig("Ejemplo19C.pdf")


CnSim(u,v,Usim,Vsim) = (1/n) * sum( (Usim .≤ u) .* (Vsim .≤ v) )

function métodoABC(θmin, θmax, m, k)
    θsim = rand(Uniform(θmin, θmax), m)
    ε = zeros(m)
    for j ∈ 1:m
        Usim, Vsim = simulaCopula(θsim[j], n)
        for i ∈ 1:n
            ε[j] += (Cn(U[i], V[i]) - CnSim(U[i], V[i], Usim, Vsim))^2
        end
    end
    jopt = sortperm(ε)[1:k]
    return θsim[jopt], ε[jopt]
end

begin
    θmin = 0.01
    θmax = 2.5
    m = 100_000
    k = 300
    θopt, εopt = métodoABC(θmin, θmax, m, k)
end

mean(θopt)
quantile(θopt, [0.025, 0.5, 0.975])

begin
    histogram(θopt, normalize = true, xlabel = L"θ", ylabel = "Densidad a posteriori",
             label = "", size = (500, 500), color = :lightyellow
    )
    vline!([quantile(θopt, 0.975)], lw = 3, color = :blue, label = "Cuantil 97.5% = $(round(quantile(θopt, 0.975), digits = 3))")   
    vline!([median(θopt)], lw = 3.5, color = :red, label = "Mediana = $(round(mean(θopt), digits = 3))")
    vline!([quantile(θopt, 0.025)], lw = 3, color = :green, label = "Cuantil 2.5% = $(round(quantile(θopt, 0.025), digits = 3))")
end
savefig("Ejemplo19D.pdf")
