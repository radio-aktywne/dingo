let utils.metadata = {}

def utils.metadata.title(md) =
  def find(key) =
    predicate = fun (m) -> string.lowercase(fst(m)) == string.lowercase(key)
    snd(list.find(default=(key, ""), predicate, md))
  end

  artist = find("artist")
  title = find("title")

  if
    artist != "" and title != ""
  then
    "#{artist} - #{title}"
  elsif title != "" then title
  else
    constants.metadata.defaults.title
  end
end

def utils.metadata.transform(transforms, source) =
  def map(t, md) =
    key = fst(t)
    functions = snd(t)

    update = fst(functions)
    insert = snd(functions)

    predicate = fun (m) -> string.lowercase(fst(m)) == string.lowercase(key)
    exists = list.exists(predicate, md)

    (key, exists ? update(list.find(predicate, md), md) : insert(md) )
  end

  def transform(md) =
    list.map(fun (t) -> map(t, md), transforms)
  end

  metadata.map(update=false, transform, source)
end
