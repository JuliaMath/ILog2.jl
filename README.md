# ILog2

[![Build Status](https://travis-ci.com/jlapeyre/ILog2.jl.svg?branch=master)](https://travis-ci.com/jlapeyre/ILog2.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/jlapeyre/ILog2.jl?svg=true)](https://ci.appveyor.com/project/jlapeyre/ILog2-jl)
[![Codecov](https://codecov.io/gh/jlapeyre/ILog2.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jlapeyre/ILog2.jl)
[![Coveralls](https://coveralls.io/repos/github/jlapeyre/ILog2.jl/badge.svg?branch=master)](https://coveralls.io/github/jlapeyre/ILog2.jl?branch=master)

This package provides `ilog2`.

`ilog2(n::Real)` compute the largest `m` such that `2^m <= n`.

Benchmarks

```
julia> using ILog2; using BenchmarkTools;

julia> myilog2(x) = Int(floor(log(2, x))); # faster than log2(x)

julia> f64 = 64.0; f65 = 65.0;

julia> @btime myilog2($f64);
  16.734 ns (0 allocations: 0 bytes)

julia> @btime ilog2($f64);
  0.015 ns (0 allocations: 0 bytes)

julia> @btime myilog2($f65);
  16.730 ns (0 allocations: 0 bytes)

julia> @btime ilog2($f65);
  9.836 ns (0 allocations: 0 bytes)

julia> i2_11 = 2^11; i2_11p1 = i2_11 + 1;

julia> @btime myilog2($i2_11);
  27.698 ns (0 allocations: 0 bytes)

julia> @btime ilog2($i2_11);
  0.015 ns (0 allocations: 0 bytes)

julia> @btime myilog2($i2_11p1);
  30.742 ns (0 allocations: 0 bytes)

julia> @btime ilog2($i2_11p1);
  7.003 ns (0 allocations: 0 bytes)
```
