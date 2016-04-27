@load_symbol _active_info :inform_active_info _libinform

activeinfo(xs :: Vector{Any}, k; b=2) = convert(Float64,NaN)

function activeinfo(xs :: Vector{Int}, k; b=max(2, maximum(xs)+1))
    if isempty(xs)
        convert(Float64, NaN)
    else
        ccall(_active_info, Float64, (Ptr{Int}, Int, Int, Int),
            xs, length(xs), b, k)
    end
end
