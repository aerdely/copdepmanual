## Ejemplo 18: Cópula Bernstein 

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


θ = 1
n = 4_000
U, V = simulaCopula(θ, n)

scatter(U, V, xlabel = L"U", ylabel = L"V", legend = false, size = (500, 500), markersize = 0.5)
savefig("Ejemplo18A.pdf")

C(u,v) = (u^(-θ) + v^(-θ) - 1)^(-1/θ)
VC(u,v) = u - C(u, 1-v)
Cn(u,v) = (1/n) * sum( (U .≤ u) .* (V .≤ v) )

function CopBer(u, v, m)
    valor = 0.0
    uu = range(0, 1, m+1)
    vv = range(0, 1, m+1)
    copemp = [Cn(u,v) for u in uu, v in vv]
    for i ∈ 1:m+1
        for j ∈ 1:m+1
            valor += copemp[i,j] * pdf(Binomial(m, u), i-1) * pdf(Binomial(m, v), j-1)
        end
    end
    return valor
end


Cn(.5,.5)
VC(.5,.5)
CopBer(.5,0.5, 100)

begin
    m = 50
    uu = range(0, 1, m+1)
    vv = range(0, 1, m+1)
end

begin
    Copula = [VC(u,v) for u in uu, v in vv] 
    nivCopula = contour(uu, vv, Copula, xlabel = L"u", ylabel = L"v",
                        xticks = [0, 0.5, 1], yticks = [0, 0.5, 1], 
                        fill = true, size = (500, 500)
    )
end
savefig("Ejemplo18B.pdf")

begin
    Copula = [Cn(u,v) for u in uu, v in vv] 
    nivCopula = contour(uu, vv, Copula, xlabel = L"u", ylabel = L"v",
                        xticks = [0, 0.5, 1], yticks = [0, 0.5, 1], 
                        fill = true, size = (500, 500)
    )
end
savefig("Ejemplo18C.pdf")

begin
    Copula = [CopBer(u,v,100) for u in uu, v in vv] 
    nivCopula = contour(uu, vv, Copula, xlabel = L"u", ylabel = L"v",
                        xticks = [0, 0.5, 1], yticks = [0, 0.5, 1], 
                        fill = true, size = (500, 500)
    )
end
savefig("Ejemplo18D.pdf")
