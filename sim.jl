using Plots, SolidStateDetectors, Unitful

sim = Simulation{Float64}("configs/simple.yaml")
simulate!(sim, refinement_limits = [0.2, 0.1, 0.05, 0.01]);
plt1 = plot(sim.electric_potential, colormap=:magma,
            title="", colorbar_title="", xunit=u"cm", yunit=u"cm",
            unitformat=:square, ratio=1)

raxis = sim.electric_potential.grid.axes[1]
zaxis = sim.electric_potential.grid.axes[3]

include("approxana.jl")
anapotential = [Φ(100r, 100z, 1:200) for (r,z) in Iterators.product(raxis,zaxis)]
plt2 = heatmap(raxis, zaxis, (r,z)->Φ(100r,100z,1:200), colormap=:magma,
               xlabel="r [m]", ylabel="z [m]", ratio=1, clims=(-1.0, 0.0))

numpotential = sim.electric_potential[:,1,:]
dif = anapotential .- numpotential
plt3 = heatmap(raxis, zaxis, dif, clims=extrema(dif))

sim2 = Simulation{Float64}("configs/simple.yaml")
simulate!(sim2, refinement_limits = [0.2, 0.1, 0.05, 0.01]);
plt4 = plot(sim2.electric_potential, colormap=:magma,
            title="", colorbar_title="", xunit=u"cm", yunit=u"cm",
            unitformat=:square, ratio=1)
raxis2 = sim2.electric_potential.grid.axes[1]
zaxis2 = sim2.electric_potential.grid.axes[3]
plt5 = heatmap(raxis2, zaxis2, (r,z)->Φ₂(100r,100z,0.3f0,0.7f0,1:200),
        colormap=:magma, clims=(-1.0, 0.0), ratio=1,
        xlabel="r [m]", ylabel="z [m]"))

function savefigs()
    savefig(plt1, "../report/figures/simple_numerical_potential.png")
    savefig(plt2, "../report/figures/simple_analytical_potential.png")
    savefig(plt3, "../report/figures/simple_difference.png")
    savefig(plt4, "../report/figures/hollow_numerical_potential.png")
    savefig(plt5, "../report/figures/hollow_analytical_potential.png")
end

