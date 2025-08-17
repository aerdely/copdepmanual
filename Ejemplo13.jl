## Ejemplo 13: Pegando W y M 

using Plots, LaTeXStrings

begin
    uu = range(0, 1, length = 100)
    vv = range(0, 1, length = 100)
    W(u,v) = max(u+v-1,0)
    Π(u,v) = u*v
    M(u,v) = min(u,v) 
end;

function pegar(θ, C1, C2)
    function C(u,v)
        if min(u,v) < 0 || max(u,v) > 1 
            return NaN
        elseif 0 ≤ u ≤ θ 
            return θ*C1(u/θ, v)
        else
            return (1-θ)*C2((u-θ)/(1-θ), v) + θ*v
        end
    end
    return C
end

CWM = pegar(0.5, W, M)
CMW = pegar(0.5, M, W)

matCWM = [CWM(u,v) for u ∈ uu, v ∈ vv]
matCMW = [CMW(u,v) for u ∈ uu, v ∈ vv]  


# curvas de nivel

nivWM = contour(uu, vv, matCWM, xlabel = L"u", ylabel = L"v", title = L"W\,\,\boxplus_{0.5}\,M",
                fill = true, size = (500, 500)
)
savefig("Ejemplo13A.pdf")

nivMW = contour(uu, vv, matCMW, xlabel = L"u", ylabel = L"v", title = L"M\,\,\boxplus_{0.5}\,W",
                fill = true, size = (500, 500)
)
savefig("Ejemplo13B.pdf")


# diagonal

begin
    t = range(0, 1, length = 1_000)
    plot([0, 1],[0, 1], label = "", color = :white, size = (500,500), lw = 0.1)
    xticks!([0,0.5,1]); yticks!([0,1])
    xaxis!(L"t"); yaxis!(L"\delta_{\!C}(t)") 
    title!(L"\delta_{\!C}(t)\,=\, (W\,\boxplus_{0.5}\,M)(t,t),\quad t\in[0,1]")
    plot!(Shape([0,1/2,1], [0,0,1]), label = L"\!\!\supset \delta_{C}(t)", color = :lightgray)
    plot!(t, t, lw = 3, color = :green3, label = L"M")
    plot!(t, t .^ 2, lw = 3, color = :blue, label = L"\Pi")
    plot!(t, max.(2 .* t .- 1, 0), lw = 3, color = :red, label = L"W")
    vline!([0.5], label = L"\theta=0.5", color = :black, lw = 1, linestyle = :dash)
    δWM(t) = CWM(t, t)
    plot!(t, δWM.(t), lw = 4, color = :black, label = L"W\,\boxplus_{0.5}\,M")
end
savefig("Ejemplo13C.pdf")

begin
    t = range(0, 1, length = 1_000)
    plot([0, 1],[0, 1], label = "", color = :white, size = (500,500), lw = 0.1)
    xticks!([0,0.5,1]); yticks!([0,1])
    xaxis!(L"t"); yaxis!(L"\delta_{\!C}(t)") 
    title!(L"\delta_{\!C}(t)\,=\, (M\,\boxplus_{0.5}\,W)(t,t),\quad t\in[0,1]")
    plot!(Shape([0,1/2,1], [0,0,1]), label = L"\!\!\supset \delta_{C}(t)", color = :lightgray)
    plot!(t, t, lw = 3, color = :green3, label = L"M")
    plot!(t, t .^ 2, lw = 3, color = :blue, label = L"\Pi")
    plot!(t, max.(2 .* t .- 1, 0), lw = 3, color = :red, label = L"W")
    vline!([0.5], label = L"\theta=0.5", color = :black, lw = 1, linestyle = :dash)
    δMW(t) = CMW(t, t)
    plot!(t, δMW.(t), lw = 4, color = :black, label = L"M\,\boxplus_{0.5}\,W")
end
savefig("Ejemplo13D.pdf")
