# ReversedStrings
provides a lazy reverse `AbstractString` interface implementation with methods
- `firstindex`
- `lastindex`
- `length`
- `iterate`
- `thisind`
- `prevind`
- `nextind`
- `getindex`
- `isvalid`
- `SubString`
- `ncodeunits`
- `codeunit`



```julia
julia> using ReversedStrings


julia> using BenchmarkTools

julia> @btime reverse("JuliaCon")
  28.694 ns (1 allocation: 32 bytes)
"noCailuJ"

julia> @btime reversed("JuliaCon")
  3.167 ns (0 allocations: 0 bytes)
"noCailuJ"

julia> @btime reverse(reverse("JuliaCon"))
  58.530 ns (2 allocations: 64 bytes)
"JuliaCon"

julia> @btime reversed(reversed("JuliaCon"))
  3.734 ns (0 allocations: 0 bytes)
"JuliaCon"
```

The package is used in [CombinedParsers.jl](https://github.com/gkappler/CombinedParsers.jl) for lookbehind parsers.

https://discourse.julialang.org/t/what-is-the-interface-of-abstractstring/8937
