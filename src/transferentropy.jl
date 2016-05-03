@load_symbol _transfer_entropy :inform_transfer_entropy _libinform
@load_symbol _transfer_entropy_ensemble :inform_transfer_entropy_ensemble _libinform

function transferentropy(ys :: Vector{Int}, xs :: Vector{Int}, k;
                         b=max(2, max(maximum(xs),maximum(ys))+1))
    if length(xs) != length(ys)
        error("series must have the same shape")
    end
    ccall(_transfer_entropy, Float64, (Ptr{Int}, Ptr{Int}, Int, Int, Int), ys, xs, length(xs), b, k)
end

function transferentropy(ys :: Array{Int,2}, xs :: Array{Int,2}, k;
                         b=max(2, max(maximum(xs),maximum(ys))+1))
    if size(xs) != size(ys)
        error("series must have the same shape")
    end
    ccall(_transfer_entropy_ensemble, Float64, (Ptr{Int}, Ptr{Int}, Int, Int, Int, Int),
        ys, xs, size(xs,2), size(xs,1), b, k)
end
