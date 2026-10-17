let utils.store.file = {}

def utils.store.file.build(~default, path) =
  def get() =
    file.exists(path) ? file.contents(path) : default
  end

  def set(value) =
    file.write(data=value, path)
  end

  {get = get, set = set}
end
