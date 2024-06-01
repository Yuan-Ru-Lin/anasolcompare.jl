To reproduce the results,

1. install Julia by following instructions in https://julialang.org/downloads/;
2. clone this repo;
3. in the root directory of this repo, execute `julia --project=./` (note the period after `=`!);
4. in the REPL, press `]` to get into the Pkg mode, type `instantiate` and hit Enter;
5. get back to the Julian mode by pressing backspace;
6. evaluate `include("main.jl")` to save figures (by default in `./results`).
