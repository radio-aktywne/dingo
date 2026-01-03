let streams = {}

let streams.radio =
  mksafe(
    utils.metadata.filter(
      constants.metadata.keys,
      fallback(
        track_sensitive=false,
        [inputs.live, inputs.playlist, inputs.fallback]
      )
    )
  )
