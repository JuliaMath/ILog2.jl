# ILog2

[![Build Status](https://github.com/jlapeyre/ILog2.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/jlapeyre/ILog2.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/jlapeyre/ILog2.jl?svg=true)](https://ci.appveyor.com/project/jlapeyre/ILog2-jl)
[![Codecov](https://codecov.io/gh/jlapeyre/ILog2.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jlapeyre/ILog2.jl)
[![Coveralls](https://coveralls.io/repos/github/jlapeyre/ILog2.jl/badge.svg?branch=master)](https://coveralls.io/github/jlapeyre/ILog2.jl?branch=master)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![JET QA](https://img.shields.io/badge/JET.jl-%E2%9C%88%EF%B8%8F-%23aa4444)](https://github.com/aviatesk/JET.jl)

This package provides a fast implementation of the integer-valued, base-2 logarithm.
`ilog2` supports other types of numbers, as well. It also provides `checkispow2`.

`ilog2(n::Real)` compute the largest `m` such that `2^m <= n`.


`ilog2(n::Real, RoundUp)` compute the smallest `m` such that `2^m >= n`.


`checkispow2(n::Number)` returns `ilog2(n)` if `n` is a power of two.
Otherwise throws a `DomainError`.
