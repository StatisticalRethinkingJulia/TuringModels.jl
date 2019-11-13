# TuringModels


[![][travis-img]][travis-url] |


## Introduction

This package contains Julia versions of the mcmc models contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath. It is part of the [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization of packages.

This package implements the models using [TuringLang/Turing.jl](https://github.com/TuringLang).

## Versions

### v1.0.0

- Set upper bounds in [compat] section of Project.toml
- Activated CompatHelper (see CompatHelpper.jl)
- No longer uses Literate.jl. This version simply contains the models.
- Some of the models are pretty slow.

### v0.5

- Based on capturing the documentation by Literate.
- Literate.jl used to generate notebook versions

## Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8 and subsequent chapters. 

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer have been a great help and followed closely in several example scripts.

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

[travis-img]: https://travis-ci.org/StatisticalRethinkingJulia/TuringModels.jl.svg?branch=master
[travis-url]: https://travis-ci.org/StatisticalRethinkingJulia/TuringModels.jl

[issues-url]: https://github.com/StatisticalRethinkingJulia/TuringModels.jl/issues
