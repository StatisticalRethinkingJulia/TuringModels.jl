using TuringModels, Literate

"""

# generate_t

Utility function to generate all notebooks and chapters from scripts in the scripts directory.

### Method
```julia
generate_t(sd = script_dict_t)
```

### Required arguments

None, all notebooks/.. and chapters/.. files are regenerated.

"""
function generate_t(sd::DataStructures.OrderedDict{AbstractString,
  Vector{ScriptEntry}} = script_dict_t)
  DocDir = rel_path_t("..", "docs", "src")

  for chapter in keys(sd)
    ProjDir = rel_path_t("..", "scripts", chapter)

    ChapterDir = rel_path_t("..", "chapters")
    !isdir(ChapterDir) && mkdir(ChapterDir)  
    ChapterDir = rel_path_t("..", "chapters", "$(chapter)")
    ScriptsDir = rel_path_t("..", "scripts", "$(chapter)")

    NotebookDir = rel_path_t("..", "notebooks")
    !isdir(NotebookDir) && mkdir(NotebookDir)  
    NotebookDir = rel_path_t("..", "notebooks", "$(chapter)")
  
    !isdir(ProjDir) && break
  
    cd(ProjDir) do
      for script in sd[chapter]
        file = script.scriptfile
      
        # Generate chapters
      
        isfile(joinpath(ChapterDir, file[1:end-3], ".jl")) && 
          rm(joinpath(ChapterDir, file[1:end-3], ".jl"))          
        Literate.script(file, ChapterDir)
      
        # Generate notebooks
      
        if script.nb && isfile(file)
          isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
            rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
          Literate.notebook(file, NotebookDir, execute=script.exe)
        end
      end
    
      # Remove tmp directory used by cmdstan 
      isdir(joinpath(ScriptsDir, "tmp")) &&
        rm(joinpath(ScriptsDir, "tmp"), recursive=true);
    
      println("\nCompleted script and notebook generation for chapter $chapter\n")
    
    end 
  end
end

"""

# generate_t

Generate notebooks and scripts in a single chapter.

### Method
```julia
generate_t(chapter::AbstractString)
```

### Required arguments

Generate notebooks and scripts in a single chapter, e.g. generate("04")

"""
function generate_t(chapter::AbstractString; sd=script_dict_t)
  split_chapter = split(chapter, "/")
  if length(split_chapter) == 2
    generate_t(split_chapter...)
  else
    DocDir = rel_path_t("..", "docs", "src")
    ProjDir = rel_path_t("..", "scripts", chapter)

    ChapterDir = rel_path_t("..", "chapters")
    !isdir(ChapterDir) && mkdir(ChapterDir)  
    ChapterDir = rel_path_t("..", "chapters", "$(chapter)")
    ScriptsDir = rel_path_t("..", "scripts", "$(chapter)")

    NotebookDir = rel_path_t("..", "notebooks")
    !isdir(NotebookDir) && mkdir(NotebookDir)  
    NotebookDir = rel_path_t("..", "notebooks", "$(chapter)")

    if isdir(ProjDir)

      cd(ProjDir) do
        for script in sd[chapter]
          file = script.scriptfile
    
          # Generate chapters
    
          isfile(joinpath(ChapterDir, file[1:end-3], ".jl")) && 
            rm(joinpath(ChapterDir, file[1:end-3], ".jl"))          
          Literate.script(file, ChapterDir)
    
          # Generate notebooks
    
          if script.nb && isfile(file)
            isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
              rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
            Literate.notebook(file, NotebookDir, execute=script.exe)
          end
        end
  
        # Remove tmp directory used by cmdstan 
        isdir(joinpath(ScriptsDir, "tmp")) &&
          rm(joinpath(ScriptsDir, "tmp"), recursive=true);
  
        println("\nCompleted script and notebook generation for chapter $chapter\n")
  
      end 
    end
  end
end

"""

# generate_t

Generate a single notebook and script

### Method
```julia
generate_t(chapter::AbstractString, file::AbstractString)
```

### Required arguments

Generate notebook and script `file` in `chapter`, e.g. generate_t("04", "m4.1d.jl")
or  generate_t("04/m4.1t.jl")

"""
function generate_t(chapter::AbstractString, scriptfile::AbstractString; sd=script_dict_t)
  DocDir = rel_path_t("..", "docs", "src")
  ProjDir = rel_path_t("..", "scripts", chapter)

  ChapterDir = rel_path_t("..", "chapters")
  !isdir(ChapterDir) && mkdir(ChapterDir)  
  ChapterDir = rel_path_t("..", "chapters", "$(chapter)")
  ScriptsDir = rel_path_t("..", "scripts", "$(chapter)")

  NotebookDir = rel_path_t("..", "notebooks")
  !isdir(NotebookDir) && mkdir(NotebookDir)  
  NotebookDir = rel_path_t("..", "notebooks", "$(chapter)")

  if isdir(ProjDir)

    cd(ProjDir) do
      for script in sd[chapter]
        !(script.scriptfile == scriptfile) && continue
        file = script.scriptfile
    
        # Generate chapters
    
        isfile(joinpath(ChapterDir, file[1:end-3], ".jl")) && 
          rm(joinpath(ChapterDir, file[1:end-3], ".jl"))          
        Literate.script(file, ChapterDir)
    
        # Generate notebooks
    
        if script.nb && isfile(file)
          isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
            rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
          Literate.notebook(file, NotebookDir, execute=script.exe)
        end
      end
  
      # Remove tmp directory used by cmdstan 
      isdir(joinpath(ScriptsDir, "tmp")) &&
        rm(joinpath(ScriptsDir, "tmp"), recursive=true);
  
      println("\nCompleted script and notebook generation for chapter $chapter\n")
  
    end 
  end
end
