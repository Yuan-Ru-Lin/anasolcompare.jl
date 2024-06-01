isdir("./results") || mkdir("./results/")

include("recipes.jl")
plot(Fig("configs/simple.yaml"))
savefig("results/simple_setup.png")
plot(Fig("configs/hollow.yaml"))
savefig("results/hollow_setup.png")

include("sim.jl")
savefigs("./results/")
