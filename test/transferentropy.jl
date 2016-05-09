# transfer entropy functions load correctly
@test Inform._transfer_entropy_found
@test Inform._transfer_entropy != C_NULL
@test isa(Inform._transfer_entropy, Ptr{Void})

@test Inform._transfer_entropy_ensemble_found
@test Inform._transfer_entropy_ensemble != C_NULL
@test isa(Inform._transfer_entropy_ensemble, Ptr{Void})

## Individual time series

# series too short
# @test isnan(transferentropy(Int[],Int[],2))
@test isnan(transferentropy([1],[1],2))

# history too long
@test isnan(transferentropy([1,1],[1,1],2))
@test !isnan(transferentropy([1,1,0],[1,1,0],2))

# series are different shapes
@test_throws ErrorException transferentropy([1,1,1],[1,1,1,1],2)
@test_throws ErrorException transferentropy([1,1,1,1],[1,1,1],2)

# encoding error
let xseries = [2,1,0,0,1]
    yseries = [0,0,1,0,1]
    @test !isnan(transferentropy(yseries, xseries, 2, b=3))
    @test isnan(transferentropy(yseries, xseries, 2, b=2))

    @test !isnan(transferentropy(xseries, yseries, 2, b=3))
    @test !isnan(transferentropy(xseries, yseries, 2, b=2))
end

let xseries = [1,1,1,0,2]
    yseries = [0,0,1,0,1]
    @test !isnan(transferentropy(yseries, xseries, 2, b=3))
    @test isnan(transferentropy(yseries, xseries, 2, b=2))

    @test !isnan(transferentropy(xseries, yseries, 2, b=3))
    @test !isnan(transferentropy(xseries, yseries, 2, b=2))
end

let xseries = [1,1,1,2,1]
    yseries = [0,0,1,0,1]
    @test !isnan(transferentropy(yseries, xseries, 2, b=3))
    @test isnan(transferentropy(yseries, xseries, 2, b=2))

    @test !isnan(transferentropy(xseries, yseries, 2, b=3))
    @test isnan(transferentropy(xseries, yseries, 2, b=2))
end

let xseries = [1,1,1,0,0]
    yseries = [1,1,0,0,1]
    @test_approx_eq_eps transferentropy(xseries, xseries, 2) 0.000000 1e-6
    @test_approx_eq_eps transferentropy(yseries, xseries, 2) 0.666666 1e-6
    @test_approx_eq_eps transferentropy(xseries, yseries, 2) 0.000000 1e-6
    @test_approx_eq_eps transferentropy(yseries, yseries, 2) 0.000000 1e-6
end

let xseries = [0,0,1,1,1,0,0,0,0,1]
    yseries = [1,1,0,0,0,0,0,0,1,1]
    @test_approx_eq_eps transferentropy(xseries, xseries, 2) 0.000000 1e-6
    @test_approx_eq_eps transferentropy(yseries, xseries, 2) 0.500000 1e-6
    @test_approx_eq_eps transferentropy(xseries, yseries, 2) 0.106844 1e-6
    @test_approx_eq_eps transferentropy(yseries, yseries, 2) 0.000000 1e-6
end

let xseries = [0,1,0,1,0,0,1,1,0,0]
    yseries = [0,0,1,0,1,1,1,0,1,1]
    @test_approx_eq_eps transferentropy(xseries, xseries, 2) 0.000000 1e-6
    @test_approx_eq_eps transferentropy(yseries, xseries, 2) 0.344361 1e-6
    @test_approx_eq_eps transferentropy(xseries, yseries, 2) 0.250000 1e-6
    @test_approx_eq_eps transferentropy(yseries, yseries, 2) 0.000000 1e-6
end

## Ensemble time series
let xseries = [
        1 1 1 0 0 1 1 0 1 0;
        0 1 0 1 1 1 0 0 0 0;
        0 0 0 1 0 0 0 1 0 0;
        0 0 1 0 0 0 1 0 0 1;
        0 0 1 1 1 1 1 0 0 0]'
    yseries = [
        0 1 0 0 0 1 0 1 1 0;
        0 0 0 1 1 1 0 1 0 0;
        1 0 1 0 1 0 0 0 1 0;
        0 1 1 0 1 1 1 1 1 1;
        0 0 1 1 0 0 0 0 0 1]'
    @test_approx_eq_eps transferentropy(xseries, xseries, 2) 0.000000 1e-6
    @test_approx_eq_eps transferentropy(yseries, xseries, 2) 0.091141 1e-6
    @test_approx_eq_eps transferentropy(xseries, yseries, 2) 0.107630 1e-6
    @test_approx_eq_eps transferentropy(yseries, yseries, 2) 0.000000 1e-6

    @test_approx_eq_eps transferentropy(xseries[:,1:4], xseries[:,1:4], 2) 0.000000 1e-6
    @test_approx_eq_eps transferentropy(yseries[:,1:4], xseries[:,1:4], 2) 0.134536 1e-6
    @test_approx_eq_eps transferentropy(xseries[:,1:4], yseries[:,1:4], 2) 0.089517 1e-6
    @test_approx_eq_eps transferentropy(yseries[:,1:4], yseries[:,1:4], 2) 0.000000 1e-6
end

let xseries = [
        0 1 0 1 0 0 1 1 1 1;
        0 1 0 1 1 1 0 0 1 0;
        1 1 1 1 0 0 1 1 1 1;
        1 0 0 0 0 0 0 0 1 0;
        0 1 1 1 1 1 0 1 1 1]'
    yseries = [
        1 1 1 1 1 0 0 0 1 0;
        0 1 1 0 0 1 1 0 0 0;
        0 1 1 1 0 1 0 0 0 0;
        0 1 0 0 1 1 0 1 0 0;
        0 1 1 1 1 0 1 1 1 1]'
    @test_approx_eq_eps transferentropy(xseries, xseries, 2) 0.000000 1e-6
    @test_approx_eq_eps transferentropy(yseries, xseries, 2) 0.031471 1e-6
    @test_approx_eq_eps transferentropy(xseries, yseries, 2) 0.152561 1e-6
    @test_approx_eq_eps transferentropy(yseries, yseries, 2) 0.000000 1e-6

    @test_approx_eq_eps transferentropy(xseries[:,1:4], xseries[:,1:4], 2) 0.000000 1e-6
    @test_approx_eq_eps transferentropy(yseries[:,1:4], xseries[:,1:4], 2) 0.172618 1e-6
    @test_approx_eq_eps transferentropy(xseries[:,1:4], yseries[:,1:4], 2) 0.206156 1e-6
    @test_approx_eq_eps transferentropy(yseries[:,1:4], yseries[:,1:4], 2) 0.000000 1e-6
end
