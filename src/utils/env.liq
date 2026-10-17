let utils.env = {}

def utils.env.get(key) =
  try
    list.assoc(key, environment())
  catch _ : [error.not_found] do
    null
  end
end

def utils.env.safeget(~default, key) =
  list.assoc(default=default, key, environment())
end
