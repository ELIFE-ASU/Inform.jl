# transfer entropy functions load correctly
@test Inform._transfer_entropy_found
@test Inform._transfer_entropy != C_NULL
@test isa(Inform._transfer_entropy, Ptr{Void})

@test Inform._transfer_entropy_ensemble_found
@test Inform._transfer_entropy_ensemble != C_NULL
@test isa(Inform._transfer_entropy_ensemble, Ptr{Void})
