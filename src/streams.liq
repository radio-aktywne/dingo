let streams = {}

let streams.main =
  begin
    phase = ref("startup")

    def transition() =
      destination = if inputs.live.playable() then "live" else "playlist" end

      if
        phase() == "transition"
      then
        if destination == "playlist" then inputs.playlist.skip() end

        phase := destination
        false
      elsif
        phase() != "startup" and phase() != destination
      then
        phase := "transition"
        true
      else
        phase := destination
        false
      end
    end

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
              track_sensitive=fun () ->
                phase() == "transition" or not inputs.live.interruptible(),
              [
                (fun () -> transition(), inputs.transition),
                (fun () -> inputs.live.playable(), inputs.live),
                (fun () -> not inputs.live.playable(), inputs.playlist)
              ]
            ),
            inputs.fallback
          ]
        )
      )
    )
  end
