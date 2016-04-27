using Inform
using Base.Test

@test Inform._libinform_found
@test Inform._libinform != C_NULL
@test isa(Inform._libinform, Ptr{Void})

@test Inform._active_info_found
@test Inform._active_info != C_NULL
@test isa(Inform._active_info, Ptr{Void})
