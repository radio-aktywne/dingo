let utils.store.cached = {}

def utils.store.cached.build(~ttl, store) =
  cached = ref(store.get())
  last = ref(time())

  def get() =
    now = time()

    if
      now - last() > ttl
    then
      last := now
      cached := store.get()
    end

    cached()
  end

  def set(value) =
    store.set(value)
    cached := value
    last := time()
  end

  {get = get, set = set}
end
