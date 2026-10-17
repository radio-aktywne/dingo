let utils.source = {}

def utils.source.optional(value, build) =
  null.case(value, fun () -> sine(duration=0.0), fun (v) -> build(v))
end

def utils.source.variable(~track_sensitive=true, get, build) =
  initialized = ref(false)
  vref = ref(null)

  def next() =
    v = get()

    if
      initialized() and v == vref()
    then
      null
    else
      initialized := true
      vref := v
      build(v)
    end
  end

  source.dynamic(track_sensitive=track_sensitive, next)
end
