using ILog2
using Test

@testset "ILog2.jl" begin
    a = [0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3,
          4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
          5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
          5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6,
          6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
          6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6]
    @test ilog2.(1:100) == a
    @test ilog2.(Int128(1):100) == a
    @test ilog2(big"2"^1000) == 1000
end

@testset "types" begin
    n = 64
    n1 = n + 1
    ln = 6
    for T in (Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64, Int128, UInt128, BigInt, Float64, BigFloat)
        @test ilog2(T(n)) == ln
        @test ilog2(T(n1)) == ln
    end
end
