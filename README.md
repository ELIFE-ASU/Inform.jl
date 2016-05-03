# Inform.jl

Inform.jl is a Julia wrapper for the [inform](https://github.com/elife-asu/inform) library. At present is only exports active information and transfer entropy.

## Build and Install

Inform.jl requires the [inform](https://github.com/elife-asu/inform), but otherwise has no dependencies. To install and test, fire up a repl:

```Julia
julia> Pkg.clone("git@github.com:elife-asu/Inform.jl.git")
julia> Pkg.test("Inform")
```

And you're ready to start using the wrapper!

```Julia
julia> using Inform
julia> activeinfo([0,0,1,1,1,1,0,0,0], 2)
0.305958492868041
```

# System Requirements

Inform.jl required Julia 4.0 or better, and has been tested under
- Debian 8
- Mac OS X 10.11 (El Capitan)
