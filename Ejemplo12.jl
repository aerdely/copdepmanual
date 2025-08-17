## Ejemplo 12: Combinación lineal convexa de W, Π y M

using Plots, LaTeXStrings

begin
    uu = range(0, 1, length = 100)
    vv = range(0, 1, length = 100)
    W(u,v) = max(u+v-1,0)
    Π(u,v) = u*v
    M(u,v) = min(u,v) 
end;

begin
    α, β = 0.5, 0.5
    C(u,v) = α*W(u,v) + (1-α-β)*Π(u,v) + β*M(u,v)
    copula = [C(u,v) for u ∈ uu, v ∈ vv]
end;


# curvas de nivel 

nivW = contour(uu, vv, W, xlabel = L"u", ylabel = L"v", title = L"W(u,v)",
               fill = true, size = (500, 500)
)

nivC = contour(uu, vv, C, xlabel = L"u", ylabel = L"v", title = L"C(u,v) = \frac{1}{2}W(u,v) + \frac{1}{2}M(u,v)",
               fill = true, size = (500, 500)
)
savefig("Ejemplo12A.pdf")

nivM = contour(uu, vv, M, xlabel = L"u", ylabel = L"v", title = L"M(u,v)",
               fill = true, size = (500, 500)
)


# diagonal

begin
    t = range(0, 1, length = 1_000)
    plot([0, 1],[0, 1], label = "", color = :white, size = (500,500), lw = 0.1)
    xticks!([0,0.5,1]); yticks!([0,1])
    xaxis!(L"t"); yaxis!(L"\delta_{\!C}(t)") 
    title!(L"\delta_{\!C}(t)\,=\,\frac{1}{2}\delta_W(t)+\frac{1}{2}\delta_M(t)")
    plot!(Shape([0,1/2,1], [0,0,1]), label = L"\!\!\supset \delta_{C}(t)", color = :lightgray)
    plot!(t, t, lw = 3, color = :green3, label = L"M")
    plot!(t, t .^ 2, lw = 3, color = :blue, label = L"\Pi")
    plot!(t, max.(2 .* t .- 1, 0), lw = 3, color = :red, label = L"W")
    δ(t) = C(t, t)
    plot!(t, δ.(t), lw = 4, color = :black, label = L"C_{1/2}")
end
savefig("Ejemplo12B.pdf")
