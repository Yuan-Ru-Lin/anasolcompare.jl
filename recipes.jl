using Plots, SolidStateDetectors, Unitful
using RecipesBase

struct Fig
    path::String
end

@recipe function f(fig::Fig)
    sim = Simulation{Float32}(fig.path)
    @series begin
        camera --> (25, 50)
        label --> ["-1V" "0V"]
        legend --> :outertopright
        xunit --> u"cm"
        yunit --> u"cm"
        zunit --> u"cm"
        n_vert_lines --> 16
        sim.detector
    end
end

