@def prepath = "TuringModels.jl"
@def website_title = "TuringModels"
@def website_descr = "Statistical Rethinking models in Julia"
@def website_url = "https://statisticalrethinkingjulia.github.io/TuringModels.jl/"

@def author = "Rob Goedman, Richard Torkar, Rik Huijzer, Martin Trapp and contributors"

@def mintoclevel = 2

<!--
Add here files or directories that should be ignored by Franklin, otherwise
these files might be copied and, if markdown, processed by Franklin which
you might not want. Indicate directories by ending the name with a `/`.
-->
@def ignore = ["node_modules/", "franklin", "franklin.pub"]

<!--
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
