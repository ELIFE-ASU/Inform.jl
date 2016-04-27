@load_symbol _active_info :inform_active_info _libinform
@load_symbol _active_info_ensemble :inform_active_info_ensemble _libinform

activeinfo(xs :: Vector{Any}, k; b=2) = convert(Float64,NaN)

function activeinfo(xs :: Vector{Int}, k; b=max(2, maximum(xs)+1))
    if isempty(xs)
        convert(Float64, NaN)
    else
        ccall(_active_info, Float64, (Ptr{Int}, Int, Int, Int),
            xs, length(xs), b, k)
    end
end

function activeinfo(xs :: Array{Int,2}, k; b=max(2, maximum(xs)+1))
    ccall(_active_info_ensemble, Float64, (Ptr{Int}, Int, Int, Int, Int),
        xs, size(xs,2), size(xs,1), b, k)
end
