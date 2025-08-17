## Ejemplo 17: Cópula Normal (o Gaussiana)

using Plots, LaTeXStrings, Distributions

r = -0.5
N2 = MvNormal([0,0], [1 r; r 1])

n = 4_000
XY = rand(N2, n)

X = XY[1, :]
Y = XY[2, :]

U = cdf(Normal(0,1), X)
V = cdf(Normal(0,1), Y)

begin
    scatter(X, Y, legend = false, size = (500, 500), ms = 1)
    xaxis!(L"X"); yaxis!(L"Y")
end
savefig("Ejemplo17A.pdf")

begin
    scatter(U, V, legend = false, size = (500, 500), ms = 1)
    xaxis!(L"U"); yaxis!(L"V")
end
savefig("Ejemplo17B.pdf")
