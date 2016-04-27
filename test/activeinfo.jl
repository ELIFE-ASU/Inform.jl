# series too short
@test isnan(activeinfo([],2))
@test isnan(activeinfo([1],2))

# history too long
@test isnan(activeinfo([1,1],2))
@test !isnan(activeinfo([1,1,0],2))

# encoding error
let series = [2,1,0,0,1,0,0,1]
    @test !isnan(activeinfo(series,2,b=3))
    @test isnan(activeinfo(series,2,b=2))
end

@test_approx_eq_eps activeinfo([1,1,0,0,1,0,0,1],2) 0.918296 1e-6

@test_approx_eq_eps activeinfo([1,0,0,0,0,0,0,0,0], 2) 0.000000 1e-6
@test_approx_eq_eps activeinfo([0,0,1,1,1,1,0,0,0], 2) 0.305958 1e-6
@test_approx_eq_eps activeinfo([1,0,0,0,0,0,0,1,1], 2) 0.347458 1e-6
@test_approx_eq_eps activeinfo([0,0,0,0,0,1,1,0,0], 2) 0.399533 1e-6
@test_approx_eq_eps activeinfo([1,1,1,0,0,0,0,1,1], 2) 0.305958 1e-6
@test_approx_eq_eps activeinfo([0,0,0,1,1,1,1,0,0], 2) 0.305958 1e-6
@test_approx_eq_eps activeinfo([0,0,0,0,0,0,1,1,0], 2) 0.347458 1e-6

@test_approx_eq_eps activeinfo([3,3,3,2,1,0,0,0,1], 2, b=4) 1.270942 1e-6
@test_approx_eq_eps activeinfo([2,2,3,3,3,3,2,1,0], 2, b=4) 1.270942 1e-6
@test_approx_eq_eps activeinfo([2,2,2,2,2,2,1,1,1], 2, b=4) 0.469565 1e-6

