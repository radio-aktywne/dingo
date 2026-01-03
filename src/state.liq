def state =
  def serialize((value:{playlist: {id: string}?})) =
    json.stringify(value)
  end

  def deserialize((value:string)) =
    let json.parse (v : {playlist: {id: string}?}) = value
    v
  end

  default = {playlist=null()}
  store =
    utils.store.cached.build(
      ttl=config.state.cache.ttl,
      utils.store.file.build(
        default=serialize(default),
        config.state.store.path
      )
    )

  def get() =
    deserialize(store.get())
  end

  def set(value) =
    store.set(serialize(value))
  end

  ref.make(get, set)
end
