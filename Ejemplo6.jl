# Ejemplo 6: Función cuasi-inversa

using Plots, LaTeXStrings

function F(x)
    if 0 < x < 1
        t = x/2 
    elseif 1 ≤ x ≤ 2
        t = 1/2
    elseif 2 < x < 3 
        t = (x-1)/2
    elseif x ≥ 3
        t = 1
    else
        t = 0
    end
    return t 
end

function Fi(t)
    if 0 < t < 1/2
        x = 2t 
    elseif 1/2 < t < 1
        x = 2t + 1
    else
        x = NaN 
    end
    return x 
end

begin
    x = range(-0.7, 3.7, length = 1_000)
    t = F.(x)
    plot(x, t, legend = false, lw = 4, color = :black)
    xaxis!(L"x")
    yaxis!(L"t = F_X\,(x)")
    P1 = current()
end

begin
    t = range(0.0, 1.0, length = 1_001)
    x = Fi.(t)
    plot(t, x, label = "", lw = 4, color = :black)
    xaxis!(L"t")
    yaxis!(L"x = F_X^{(-1)}(t)")
    tt = [0.0, 0.5, 0.5, 1.0]
    xx = [0.0, 1.0, 2.0, 3.0]
    scatter!(tt, xx, ms = 4, mc = :white, label = "")
    t1 = [0.0, 0.0]
    x1 = [-0.7, 0.0]
    plot!(t1, x1, label = L"x_1\!\!*\in I_1=]-\infty,0\,]", lw = 3.5, color = :lightgreen)
    t1 = [0.5, 0.5]
    x1 = [1.0, 2.0]
    plot!(t1, x1, label = L"x_2\!\!*\in I_2=[1,2]", lw = 3.5, color = :pink)
    t1 = [1.0, 1.0]
    x1 = [3.0, 3.7]
    plot!(t1, x1, label = L"x_3\!\!*\in I_3=[3,+\infty[", lw = 3.5, color = :lightblue)
    P2 = current()
end

plot(P1, P2, layout = (1,2), size = (600,400))
savefig("Ejemplo6.pdf")
