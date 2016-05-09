using Inform
using Base.Test

@test Inform._libinform_found
@test Inform._libinform != C_NULL
@test isa(Inform._libinform, Ptr{Void})

include("activeinfo.jl")
include("transferentropy.jl")
