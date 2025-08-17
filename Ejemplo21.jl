## Ejemplo 21: Cálculo de la Correlación de Spearman

using Plots, LaTeXStrings

μ(θ) = 1 - 2*θ*(1-θ) # Schweizer-Wolff 
ρ(θ) = 1 - 2*θ # Spearman    
θ = collect(range(0, 1, length = 1_000))

begin
    plot(θ, μ.(θ), label = "Schweizer-Wolff", color = :cyan3, lw = 3.3, size = (400, 400))
    xaxis!(L"θ")
    xticks!([0, 0.5, 1])
    yticks!([-1, 0, 1])
    plot!(θ, ρ.(θ), label = "Spearman", color = :orange, lw = 2.8)
end
savefig("Ejemplo21A.pdf")

begin
    plot(θ, μ.(θ), label = "Schweizer-Wolff", color = :cyan3, lw = 3.3, size = (400, 400))
    xaxis!(L"θ")
    xticks!([0, 0.5, 1])
    yticks!([0, 0.5, 1])
    plot!(θ, abs.(ρ.(θ)), label = " | Spearman |", color = :orange3, lw = 2.8)
end
savefig("Ejemplo21B.pdf")
