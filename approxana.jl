using DelimitedFiles
using SpecialFunctions

const J₀ = besselj0
const J₁ = besselj1
const v::Vector{Float64} = readdlm("J0zeros200") |> vec

function Φ(r::T, z::T, i::U) where {T <: Real, U <: Integer}
    kn = v[i]
    -2 * J₀(kn*r) * sinh(kn*z) / (kn * J₁(kn) * sinh(kn))
end

function Φ(r::T, z::T, _range::AbstractUnitRange{<:Integer}) where T <: Real
    sum(Φ(r, z, i) for i in _range)
end

function Φ₂(r::T, z::T, a::T, b::T, i::U) where {T<:Real, U<:Integer}
    kn = v[i]
    lhs = -a*J₁(a*kn)/kn + (-a*kn*log(b/a)*J₁(a*kn)+J₀(a*kn)-J₀(b*kn))/(kn^2 * log(a/b))
    lhs / (J₁(kn)^2 * sinh(kn) / 2) * J₀(kn*r) * sinh(kn*z)
end

function Φ₂(r::T, z::T, a::T, b::T, _range::AbstractUnitRange{<:Integer}) where T <: Real
    sum(Φ₂(r, z, a, b, i) for i in _range)
end
