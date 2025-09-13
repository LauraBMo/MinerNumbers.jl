using MinerNumbers
using Documenter

DocMeta.setdocmeta!(MinerNumbers, :DocTestSetup, :(using MinerNumbers); recursive=true)

makedocs(;
    modules=[MinerNumbers],
    authors="LauBMo <laurea987@gmail.com> and contributors",
    sitename="MinerNumbers.jl",
    format=Documenter.HTML(;
        canonical="https://LauraBMo.github.io/MinerNumbers.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/LauraBMo/MinerNumbers.jl",
    devbranch="main",
)
