# TuringModels

[![CI][ci-img]][ci-url]


## Introduction

This package contains Julia versions of the mcmc models contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath. It is part of the [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization of packages.

This package implements the models using [TuringLang/Turing.jl](https://github.com/TuringLang).

## Usage

Most of the scripts and output can be inspected via the [website](https://statisticalrethinkingjulia.github.io/TuringModels.jl/).
If you want to run the scripts yourselves, then you can either

1. copy the code from the webpages and the data from this repository, and run the scripts **or**
1. clone this repository and run one of the files in `scripts`. For example, `julia --project -i scripts/basic-example.jl`.

The scripts are written in [Literate.jl](https://github.com/fredrikekre/Literate.jl) to allow them to be ran stand-alone, and as part of the website.
To generate the website locally, use [Franklin.jl](https://github.com/tlienart/Franklin.jl).
Specifically, clone this repository and go into the root directory of this repository. 
Then, use
```
julia --project -ie 'using Franklin; Franklin.serve()'
```
This will activate the project environment (thanks to the `--project` flag) and will _interactively_ execute `Franklin.serve()`.
Interactively means that if serve fails, then you will still be in an active REPL session which avoids having to completely restart Julia.
Building the site for the first time will take about 20 minutes.
After building the site, it will be available on <http://localhost:8000/>.
Consecutive calls to serve will only take a few minutes because Franklin caches the output.

## Versions

### v2.0

- Show the output via Franklin.jl and Literate.jl
- Simplify code
- Use names for models instead of numbers
- Fix multiple models
- Let CI fail if an error occurs during build (to avoid manually having to check >20 webpages)
- Update README

### v1.1.2

- CI matrix simplifications
- NUTS(0.65) checking
- Replace ifelse by comprehension
- CI tests for more models

### v1.1.1

-  CompatHelper updates

### v1.0.6

-  CompatHelper updates

### v1.0.5

- CompatHelper updates
- yiyuezhuo/ch13_models update

### v1.0.4

- CompatHelper updates

### v1.0.3

- Karajan9 patch
- CompatHelper updates

### v1.0.2

- Relaxed Pkg upper bounds

### v1.0.1

- Model updates by Martin Trapp

### v1.0.0

- Set upper bounds in [compat] section of Project.toml
- Activated CompatHelper (see CompatHelper.jl)
- No longer uses Literate.jl. This version simply contains the models.
- Some of the models are pretty slow.

### v0.5

- Based on capturing the documentation by Literate.
- Literate.jl used to generate notebook versions

## Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8 and subsequent chapters. 
Martin Trapp has updated many models to recent versions of Turing.jl. 
Rik Huijzer is bringing the models in sync with the 2nd edition of the StatisticalRethinking book in addition to several other improvements.
Thibaut Lienart has given advise on how to use Franklin well.

The TuringLang team and #turing contributors on Slack have been extremely helpful! 
The Turing examples by Cameron Pfiffer and others have been a great help.

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

[ci-img]: https://github.com/StatisticalRethinkingJulia/TuringModels.jl/workflows/Deploy/badge.svg
[ci-url]: https://statisticalrethinkingjulia.github.io/TuringModels.jl/

[issues-url]: https://github.com/StatisticalRethinkingJulia/TuringModels.jl/issues
