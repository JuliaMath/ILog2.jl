# ILog2

[![Build Status](https://github.com/JuliaMath/ILog2.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/JuliaMath/ILog2.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Codecov](https://codecov.io/gh/JuliaMath/ILog2.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaMath/ILog2.jl)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![](https://img.shields.io/badge/%F0%9F%9B%A9%EF%B8%8F_tested_with-JET.jl-233f9a)](https://github.com/aviatesk/JET.jl)

This package provides a fast implementation of the integer-valued, base-2 logarithm.
`ilog2` supports other types of numbers, as well. It also provides `checkispow2`.

`ilog2(n::Real)` compute the largest `m` such that `2^m <= n`.

`ilog2(n::Real, RoundUp)` compute the smallest `m` such that `2^m >= n`.

`checkispow2(n::Number)` returns `ilog2(n)` if `n` is a power of two.
Otherwise throws a `DomainError`.
