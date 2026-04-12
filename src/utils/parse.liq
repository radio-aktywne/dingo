let utils.parse = {}

def utils.parse.float(value) =
  float_of_string(value)
end

def utils.parse.int(value) =
  int_of_string(value)
end

def utils.parse.ofloat(value) =
  value == "" ? null() : (utils.parse.float(value))
end

def utils.parse.oint(value) =
  value == "" ? null() : (utils.parse.int(value))
end
