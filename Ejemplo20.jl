## Ejemplo 20: Cálculo de la dependencia de Schweizer-Wolff 

using Plots, LaTeXStrings, Distributions

θ = 0.35

begin
    plot([0,1], [0,1], color = :white, lw = 0.1, label = "", size = (400, 400))
    xticks!([0, θ, 1], ["0", "θ", "1"])
    yticks!([0, 1])
    xaxis!(L"u"); yaxis!(L"v")
    title!(L"C_{\!\theta}(u,v) = (W\,\,\boxplus_{\theta}\,M)(u,v)")
    plot!([0, θ], [1, 0], color = :black, lw = 4, label = "")
    plot!([θ, 1], [0, 1], color = :black, lw = 4, label = "")
    annotate!([(θ+0.05, 0.65,(L"u+θv-θ", 14, :blue))])
    annotate!([(0.15, 0.2, (L"0", 14, :blue))])
    annotate!([(0.75, 0.2, (L"v", 14, :blue))])
end 
savefig("Ejemplo20A.pdf")


g(u) = max(1-u/θ, (u-θ)/(1-θ))
function C(u,v)
    if v ≥ g(u)
        return u + θ*v - θ
    elseif u ≥ θ && v < g(u)
        return v 
    else
        return 0
    end
end
D(u,v) = C(u,v) - u*v 
begin
    uu = collect(range(0, 1, length = 100))
    vv = collect(range(0, 1, length = 100))
    Z = [D(u,v) for u in uu, v in vv]
    contour(uu, vv, transpose(Z), xlabel = L"u", ylabel = L"v", fill = true, size = (400, 380))
    title!(L"C_{\theta}(u,v)-\Pi(u,v)")
    xticks!([0, θ, 1], ["0", "θ", "1"])
    yticks!([0, 1])
    plot!([0, θ], [1, 0], color = :green, lw = 3, label = "")
    plot!([θ, 1], [0, 1], color = :green, lw = 3, label = "")
    plot!([θ, θ], [0, 1], color = :green, lw = 3, label = "")
end
savefig("Ejemplo20B.pdf")


begin
    plot([0,1], [0,1], color = :white, lw = 0.1, label = "", size = (400, 400))
    xticks!([0, θ, 1], ["0", "θ", "1"])
    yticks!([0, 1])
    xaxis!(L"u"); yaxis!(L"v")
    title!(L"C_{\theta}(u,v)-\Pi(u,v)")
    plot!([0, θ], [1, 0], color = :black, lw = 1, label = "")
    plot!([θ, 1], [0, 1], color = :black, lw = 1, label = "")
    plot!([θ, θ], [0, 1], color = :black, lw = 1, label = "")
    annotate!([(0.11, 0.22, (L"D_1", 14, :red))])
    annotate!([(0.22, 0.75, (L"D_2", 14, :red))])
    annotate!([(0.57, 0.75, (L"D_3", 14, :darkgreen))])
    annotate!([(0.77, 0.22, (L"D_4", 14, :darkgreen))])
end 
savefig("Ejemplo20C.pdf")

begin
    tt = collect(range(0, 1, length = 1_000))
    d = [1 - 2*t*(1-t) for t in tt]
    plot(tt, d, xlabel = L"θ", ylabel = L"\mu_{C_θ}", label = "", 
    size = (400, 400), lw = 3, color = :cyan3
    )
    # title!("Dependencia de Schweizer-Wolff")
    hline!([0], color = :lightgray, lw = 0.1, label = "")
end
savefig("Ejemplo20D.pdf")