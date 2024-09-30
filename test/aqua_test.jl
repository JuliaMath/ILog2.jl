using ILog2
using Aqua: Aqua

@testset "aqua deps compat" begin
    Aqua.test_deps_compat(ILog2)
end

@testset "aqua unbound_args" begin
    Aqua.test_unbound_args(ILog2)
end

@testset "aqua undefined exports" begin
    Aqua.test_undefined_exports(ILog2)
end

# Perhaps some of these should be fixed. Some are for combinations of types
# that make no sense.
@testset "aqua test ambiguities" begin
    Aqua.test_ambiguities([ILog2, Core, Base])
end

@testset "aqua piracies" begin
    Aqua.test_piracies(ILog2)
end

@testset "aqua project extras" begin
    Aqua.test_project_extras(ILog2)
end

@testset "aqua state deps" begin
    Aqua.test_stale_deps(ILog2)
end
