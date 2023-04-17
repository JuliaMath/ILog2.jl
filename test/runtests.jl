using ILog2
using Test

# FIXME: Tests for other floating point types

include("aqua_test.jl")

@static if Base.VERSION >= v"1.7"
    include("jet_test.jl")
end

@testset "ILog2" begin
    bitstypes = (Int8, Int16, Int32, Int64,
                 UInt8, UInt16, UInt32, UInt64, Int128, UInt128)
    largest_Float64_corresponding_to_unique_integer = 2^53 - 1
    for T in  bitstypes
        N = min(typemax(T) - 1, largest_Float64_corresponding_to_unique_integer)
        num_trials_per_type = min(N, 10^4)
        nums = rand(T(1):T(N), num_trials_per_type)
        for n in nums
            @test ilog2(T(n)) == ilog2(float(n))
        end
    end
end

@testset  "Large Float64" begin
    x = 3e19
    @test ilog2(x) == floor(Int, log2(x))
end

@testset "BigInt" begin
    for expt in rand(10:10^4, 10^3)
        n = big(2)^expt
        np = n + rand(1:100)
        nm = n - rand(1:100)
        @test ilog2(n) == expt
        @test ilog2(np) == expt
        @test ilog2(nm) == expt - 1
        @test ilog2(n) == ilog2(float(n))
    end
end

@testset "checkispow2" begin
    @test checkispow2(2) == 1
    @test checkispow2(8) == 3
    @test checkispow2(1024.0) == 10
    @test checkispow2(1024.0) isa Int
end

@testset "exceptions" begin
    @test_throws ArgumentError ILog2.msbindex(BigInt)
    @test_throws DomainError ilog2(0)
    @test_throws DomainError ilog2(-1)

    @test_throws DomainError checkispow2(3)
end

@testset "RoundUp" begin
    @test ilog2(15) == 3
    @test ilog2(15, RoundDown) == 3
    @test ilog2(15, RoundUp) == 4
end
