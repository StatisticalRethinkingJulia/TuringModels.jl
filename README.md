# TuringModels


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] |


## Introduction

This package contains Julia versions of the mcmc models contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath. It is part of the [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization of packages.

This package implements the models using [TuringLang/Turing.jl](https://github.com/TuringLang).

## Documentation

- [**STABLE**][docs-stable-url] &mdash; **documentation of the most recently tagged version.**
- [**DEVEL**][docs-dev-url] &mdash; *documentation of the in-development version.*

## Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8 and subsequent chapters. 

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer have been a great help and followed closely in several example scripts.

The  documentation has been generated using Literate.jl and Documenter.jl based on several ideas demonstrated by Tamas Papp in above mentioned  [DynamicHMCExamples.jl](https://tpapp.github.io/DynamicHMCExamples.jl).

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://statisticalrethinkingjulia.github.io/TuringModels.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://statisticalrethinkingjulia.github.io/TuringModels.jl/stable

[travis-img]: https://travis-ci.org/StatisticalRethinkingJulia/TuringModels.jl.svg?branch=master
[travis-url]: https://travis-ci.org/StatisticalRethinkingJulia/TuringModels.jl

[codecov-img]: https://codecov.io/gh/StatisticalRethinkingJulia/TuringModels.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/StatisticalRethinkingJulia/TuringModels.jl

[issues-url]: https://github.com/StatisticalRethinkingJulia/TuringModels.jl/issues

[project-status-img]: https://img.shields.io/badge/lifecycle-wip-orange.svg

