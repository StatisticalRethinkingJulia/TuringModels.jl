 using TuringModels
using Literate
using Documenter

# The idea: generate both docs and notebooks using Literate
# Based on ideas and work from Tamas Papp!

DOC_ROOT = rel_path_t("..", "docs")
DocDir =  rel_path_t("..", "docs", "src")

page_list = Array{Pair{String, Any}, 1}();
append!(page_list, [Pair("Home", "intro.md")]);

for chapter in keys(script_dict_t)
  ProjDir = rel_path_t( "..", "scripts", chapter)
  DocDir =  rel_path_t("..", "docs", "src", chapter)
  
  !isdir(ProjDir) && break
  
  cd(ProjDir) do
    
    script_list = Array{Pair{String, Any}, 1}();
    for script in script_dict_t[chapter]
      if script.doc
        file = script.scriptfile
        append!(script_list, [Pair(file[1:end-3], "$(chapter)/$(file[1:end-3]).md")])
        if script.exe && isfile(file)
          isfile(joinpath(DocDir, file[1:end-3], ".md")) &&
            rm(joinpath(DocDir, file[1:end-3], ".md"))
          Literate.markdown(joinpath(ProjDir, file), DocDir, documenter=true)        
        end
      end
    end
    
    # Remove tmp directory used by cmdstan 
    append!(page_list, [Pair("Chapter $(chapter)", script_list)])
    isdir("tmp") && rm("tmp", recursive=true);
    println("\nCompleted documentation generation for chapter $chapter\n")
    
  end # cd
end # for chapter

append!(page_list, [Pair("Functions", "index.md")])

makedocs(root = DOC_ROOT,
    modules = Module[],
    sitename = "TuringModels.jl",
    authors = "Rob Goedman, Richard Torkar, and contributors.",
    pages = page_list
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StatisticalRethinkingJulia/TuringModels.jl.git",
 )
