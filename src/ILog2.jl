"""
    module ILog2

This module provides `ilog2`.
"""
module ILog2
import StaticArrays

export ilog2

const IntBits  = Union{Int8, Int16, Int32, Int64, Int128,
                       UInt8, UInt16, UInt32, UInt64, UInt128}

"""
    msbindex(::Type{T})
    T is an Integer bits type

Evaluates as the one less than the number of bits in T
"""
@generated function msbindex(::Type{T}) where {T<:Integer}
    return sizeof(T)*8 - 1
end

"""
    ilog2(n::Integer bitstype)

Compute the largest `m` such that `2^m <= n`.
"""
function ilog2(n::T) where {T<:IntBits}
    n > zero(T) && return msbindex(T) - leading_zeros(n)
    throw(DomainError(n))
end


ilog2(x::Real) = ilog2(convert(Integer, floor(x)))

# This is several times slower than the other methods
ilog2(n::Integer) = convert(typeof(n), floor(log(2,n)))

end # ILog2
