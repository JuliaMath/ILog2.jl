"""
    module ILog2

This module provides `ilog2`.
"""
module ILog2

export ilog2, checkispow2

const IntBits  = Union{Int8, Int16, Int32, Int64, Int128,
                       UInt8, UInt16, UInt32, UInt64, UInt128}


"""
    ilog2(x, RoundUp)

Return the smallest `m` such that `2^m >= n`.
"""
ilog2(x, ::typeof(RoundUp)) = ispow2(x) ? ilog2(x) : ilog2(x) + 1
ilog2(x, ::typeof(RoundDown)) = ilog2(x)

"""
    msbindex(::Type{T})
    T is an Integer bits type

Return one less than the number of bits in T
"""
@generated function msbindex(::Type{T}) where {T<:Integer}
    return sizeof(T)*8 - 1
end

msbindex(::Type{BigInt}) = throw(ArgumentError("Expected an integer type with fixed number of bits"))

"""
    ilog2(n::Real)

Compute the largest `m` such that `2^m <= n`.

!!! note

    `float(2^53 - 1)` is the largest `n::Float64` for which `eps(n) ≤ 1`.
    For larger `n::Float64`, "the largest `m` such that `2^m <= n`" is ambiguous, although
    `ilog2` may return a number. For large enough `n::Float64`, `ilog2` will
    throw an `InexactError`. These cautionary statements do not apply for `n::Integer`.
"""
function ilog2(n::T) where {T<:IntBits}
    n > zero(T) && return msbindex(T) - leading_zeros(n)
    throw(DomainError(n))
end
ilog2(n::BigInt) = Base.GMP.MPZ.sizeinbase(n, 2) - 1

function ilog2(x::Real)
    if x < typemax(Int)
        return fastilog2(x)
    end
    return slowilog2(x)
end

"""
    slowilog2(x::Real)

This is slower than `ilog2` for `x::Float64` with `x` less than
about `1e19` (when `Int` is `Int64`); more precisely less than `typemax(Int64)`.
However, it is slightly faster than `ilog2` when `x > typemax(Int)`.

Use `slowilog2(x::Float64)` only under exceptional circumstances: when you need 10-20% faster
ilog2 for `Float64` and `x` is very large, ie `x > typemax(Int)`.
"""
@inline function slowilog2(x::Real)
    return floor(Int, log2(x))
end

"""
    fastilog2(x::AbstractFloat)

This is slightly faster than `ilog2` for `x::Float64` with `x` less than
about `1e19` (when `Int` is `Int64`); more precisely less than `typemax(Int64)`.
However, `fastilog2` will throw an `InexactError` for
when `x > typemax(Int)`.

Use `fastilog2(::Float64)` only under exceptional circumstances: when you need 10-20% faster
ilog2 for `Float64` and the input is small enough.
"""
@inline function fastilog2(x::AbstractFloat)
    return ilog2(floor(Integer, x))
end


# This is several times slower than the other methods. But none of the standard bitstype integers,
# nor `BigInt`, dispatch to this method.
ilog2(n::Integer) = convert(typeof(n), floor(log(2,n)))

"""
    checkispow2(n::Number)

Return base-2 logarithm of `n` if `n` is a power of two.
Otherwise throw a `DomainError`.
"""
function checkispow2(n::Number)
    if ! ispow2(n)
        throw(DomainError(n, "$n is not a power of two."))
    end
    return ilog2(n)
end



end # module ILog2
