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
        [
          switch(
            track_sensitive=fun () -> not inputs.live.interruptible(),
            [(fun () -> true, inputs.live), (fun () -> true, inputs.playlist)]
          ),
          inputs.fallback
        ]
      )
    )
  )
