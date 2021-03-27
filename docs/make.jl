push!(LOAD_PATH,"../src")
using Documenter: Documenter, makedocs, deploydocs, doctest, DocMeta
using ReversedStrings
using Test

docdir = joinpath(dirname(pathof(ReversedStrings)),"../docs/src/")
mandir = joinpath(docdir,"man")
DocMeta.setdocmeta!(ReversedStrings, :DocTestSetup, quote
    using TextParse
    using ReversedStrings
end; recursive=true)


makedocs(;
         source=docdir,
         modules=[ReversedStrings],
         authors="Gregor Kappler",
         repo="https://github.com/gkappler/ReversedStrings.jl/blob/{commit}{path}#L{line}",
         sitename="ReversedStrings.jl",
         format=Documenter.HTML(;
                                prettyurls=get(ENV, "CI", "false") == "true",
                                canonical="https://gkappler.github.io/ReversedStrings.jl",
                                assets=String[],
                                ),
         pages=[
             "Home" => "index.md"
             # "Developer Guide" => "developer.md"
         ],
         )

deploydocs(;
    repo="github.com/gkappler/ReversedStrings.jl",
)
