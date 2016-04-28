# active information functions load correctly
@test Inform._active_info_found
@test Inform._active_info != C_NULL
@test isa(Inform._active_info, Ptr{Void})

@test Inform._active_info_ensemble_found
@test Inform._active_info_ensemble != C_NULL
@test isa(Inform._active_info_ensemble, Ptr{Void})

## Individual time series

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

@test_approx_eq_eps activeinfo([3,3,3,2,1,0,0,0,1], 2, b=4) 0.635471 1e-6
@test_approx_eq_eps activeinfo([2,2,3,3,3,3,2,1,0], 2, b=4) 0.635471 1e-6
@test_approx_eq_eps activeinfo([2,2,2,2,2,2,1,1,1], 2, b=4) 0.234783 1e-6

## Ensemble time series
let series = [ 1 0; 1 0; 0 0; 0 1; 1 0; 0 0; 0 0; 1 1]
    @test_approx_eq_eps activeinfo(series, 2) 0.459148 1e-6
end
let series = [
    1 0 1 1 0 0 1 0 0;
    0 0 0 0 0 0 1 0 0;
    0 1 0 0 0 0 1 0 0;
    0 1 0 0 0 0 0 1 0;
    0 1 0 0 0 1 0 1 0;
    0 1 0 0 1 1 0 1 0;
    0 0 0 0 1 0 0 1 1;
    0 0 1 1 0 0 1 0 1;
    0 0 1 1 0 0 1 0 0]
    @test_approx_eq_eps activeinfo(series, 2) 0.308047 1e-6
end

let series = [
    3 3 3 2 1 0 0 0 1;
    2 2 3 3 3 3 2 1 0;
    0 0 0 0 1 1 0 0 0;
    1 1 0 0 0 1 1 2 2]'
    @test_approx_eq_eps activeinfo(series, 2) 0.6621455 1e-6
end
