script_dict_t = DataStructures.OrderedDict{AbstractString, Vector{ScriptEntry}}(
  "00" => [
    scriptentry("section_example.jl"),
    scriptentry("mp_example.jl", exe=false, doc=false)
  ],
  "02" => [
    scriptentry("m2.1t.jl")
  ],
  "04" => [
    scriptentry("m4.2t.jl")
  ],
  "08" => [
    scriptentry("m8.1t.jl", exe=false, doc=false),
    scriptentry("m8.2t.jl", exe=false, doc=false),
    scriptentry("m8.3t.jl", exe=false, doc=false),
    scriptentry("m8.4t.jl", exe=false, doc=false)
  ],
  "10" => [
    scriptentry("m10.03t.jl", exe=false, doc=false),
    scriptentry("m10.04t.jl", exe=false, doc=false),
    scriptentry("m10.10t.jl", exe=false, doc=false),
    scriptentry("m10.10t2.jl", exe=false, doc=false),
    scriptentry("m10.xxt.jl", exe=false, doc=false),
    scriptentry("m10.yyt.jl", exe=false, doc=false)
  ],
  "11" => [
    scriptentry("m11.5t.jl", exe=false, doc=false)
  ],
  "12" => [
    scriptentry("m12.1t.jl", exe=false, doc=false),
    scriptentry("m12.2t.jl", exe=false, doc=false),
    scriptentry("m12.3t.jl", exe=false, doc=false),
    scriptentry("m12.4t.jl", exe=false, doc=false),
    scriptentry("m12.5t.jl", exe=false, doc=false),
    scriptentry("m12.6t.jl", exe=false, doc=false)
  ]
);
