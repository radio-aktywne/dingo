let streams = {}

let streams.main =
  mksafe(
    utils.metadata.filter(
      constants.metadata.keys,
      fallback(
        track_sensitive=false,
        [inputs.live, inputs.playlist, inputs.fallback]
      )
    )
  )
