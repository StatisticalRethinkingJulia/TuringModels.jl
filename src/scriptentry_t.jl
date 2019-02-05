script_dict_t = DataStructures.OrderedDict{AbstractString, Vector{ScriptEntry}}(
  "02" => [
    scriptentry("m2.1t.jl")
  ],
  "08" => [
    scriptentry("m8.1t.jl"),
    scriptentry("m8.2t.jl", exe=false, doc=false),
    scriptentry("m8.3t.jl"),
    scriptentry("m8.4t.jl")
  ],
  "10" => [
    scriptentry("m10.03t.jl"),
    scriptentry("m10.04t.jl"),
    scriptentry("m10.10t.jl"),
    scriptentry("m10.10t2.jl"),
    scriptentry("m10.xxt.jl"),
    scriptentry("m10.yyt.jl")
  ],
  "11" => [
    scriptentry("m11.5t.jl")
  ],
  "12" => [
    scriptentry("m12.1t.jl"),
    scriptentry("m12.2t.jl"),
    scriptentry("m12.3t.jl"),
    scriptentry("m12.4t.jl"),
    scriptentry("m12.5t.jl"),
    scriptentry("m12.6t.jl")
  ]
);
