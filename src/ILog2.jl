"""
    module ILog2

This module provides `ilog2`.
"""
module ILog2
import StaticArrays

export ilog2

"""
    ilog2(n::Integer)

Compute the largest `m` such that `2^m <= n`.
"""
function ilog2(n::Integer)
    n < 1 && throw(DomainError(n))
    _ispow2(n) && return _ilog2exact(n)
    return _ilog2floor(n)
end
_ispow2(n::Integer) = count_ones(n) == 1
_ilog2exact(n::Integer)::Int = trailing_zeros(n)
ilog2(x::Real) = ilog2(convert(Integer, floor(x)))

function _make_power_array(itr)
    return StaticArrays.SVector(itr...)
end
const _pows2_128 = _make_power_array(Int128(2)^i for i = 0:126)
const _pows2_U128 = _make_power_array(UInt128(2)^i for i = 0:127)
const _pows2_64 = _make_power_array(2^i for i = 0:62)
const _pows2_U64 = _make_power_array(UInt64(2)^i for i = 0:63)
const _pows2_32 = _make_power_array(2^i for i = 0:30)
const _pows2_U32 = _make_power_array(UInt32(2)^i for i = 0:31)

_ilog2floor(n::Int128) = searchsortedlast(_pows2_128, n) - 1
_ilog2floor(n::UInt128) = searchsortedlast(_pows2_U128, n) - 1
_ilog2floor(n::Int64) = searchsortedlast(_pows2_64, n) - 1
_ilog2floor(n::UInt64) = searchsortedlast(_pows2_U64, n) - 1
_ilog2floor(n::Int32) = searchsortedlast(_pows2_32, n) - 1
_ilog2floor(n::UInt32) = searchsortedlast(_pows2_U32, n) - 1
_ilog2floor(n::Union{Int8, Int16, UInt8, UInt16, UInt32}) = _ilog2floor(Int(n))

# This is several times slower than the other methods
_ilog2floor(n::Integer) = convert(typeof(n), floor(log(2,n)))

end # ILog2
