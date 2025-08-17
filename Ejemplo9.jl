## Ejemplo 9: Misma cópula con distintas marginales

using Plots, LaTeXStrings, Distributions

f(x,y) = exp(-y)*(0 < x < y)

X = Exponential(1)
Y = Gamma(2, 1)
Q(v) = quantile(Y, v)

ξ(u) = u + (1-u)*log(1-u) 

c(u,v) = (v > ξ(u)) / ((1-u)*Q(v)) 

S = Normal(0,1)
T = Beta(1/2, 1/2)

h(s,t) = c(cdf(S,s),cdf(T,t))*pdf(S,s)*pdf(T,t) 



# Graficar densidad de (X,Y)
begin
    x1 = 0; x2 = 3
    y1 = 0; y2 = 3
    n = 100
    xx = range(x1, x2, length = n)
    yy = range(y1, y2, length = n)
    zz = [f(x,y) for x in xx, y in yy]
    p1 = contour(xx, yy, transpose(zz), xlabel = L"x", ylabel = L"y", 
         title = L"f_{\!\!X,Y}", fill = true, size = (500, 500)
    )
    display(p1)    
end
savefig("Ejemplo9A.pdf")

# Graficar densidad de (U,V)
begin
    u1 = 0; u2 = 1
    v1 = 0; v2 = 1
    n = 100
    uu = range(u1, u2, length = n)
    vv = range(v1, v2, length = n)
    ww = [c(u,v) for u in uu, v in vv]
    p2 = heatmap(uu, vv, transpose(ww), xlabel = L"u", ylabel = L"v", 
         title = L"f_{\!\!U,V}\,=\,c_{X,Y}", size = (500, 500)
    )
    display(p2)    
end
savefig("Ejemplo9B.pdf")

# Graficar densidad de (S,T)
begin
    s1 = -2.3; s2 = 2.3
    t1 = 0; t2 = 1
    n = 100
    ss = range(s1, s2, length = n)
    tt = range(t1, t2, length = n)
    rr = [h(s,t) for s in ss, t in tt]
    p3 = heatmap(ss, tt, transpose(rr), xlabel = L"s", ylabel = L"t", 
         title = L"h_{S,T}", size = (500, 500)
    )
    display(p3)    
end
savefig("Ejemplo9C.pdf")
