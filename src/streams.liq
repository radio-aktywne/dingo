let streams = {}

let streams.main =
  utils.metadata.transform(
    [
      (
        "title",
        (
          fun (_, md) -> utils.metadata.title(md),
          fun (md) -> utils.metadata.title(md)
        )
      )
    ],
    mksafe(
      fallback(
        track_sensitive=false,
        [inputs.live, inputs.playlist, inputs.fallback]
      )
    )
  )
