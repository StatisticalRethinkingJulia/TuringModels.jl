# TuringModels

[![][travis-img]][travis-url] |

## Introduction

This package contains Julia versions of the mcmc models contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath. It is part of the [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization of packages.

This package implements the models using [TuringLang/Turing.jl](https://github.com/TuringLang).

## Versions

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

Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8 and subsequent chapters. Martin Trapp has updated many models to recent versions of Turing.jl. Rik Huijzer is bringing the models in sync with the 2nd edition of the StatisticalRethinking book in addition to several other improvements.

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer and others have been a great help.

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

[travis-img]: https://travis-ci.com/StatisticalRethinkingJulia/TuringModels.jl.svg?branch=master
[travis-url]: https://travis-ci.com/StatisticalRethinkingJulia/TuringModels.jl

[issues-url]: https://github.com/StatisticalRethinkingJulia/TuringModels.jl/issues
