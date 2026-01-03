let inputs = {}

let inputs.fallback = single(constants.paths.fallback)

let inputs.playlist =
  utils.source.variable(
    fun () -> state().playlist,
    fun (plst) ->
      utils.source.optional(
        plst,
        fun (p) ->
          playlist(
            prefetch=3,
            loop=true,
            mode="normal",
            reload=60,
            reload_mode="seconds",
            timeout=60.0,
            "#{config.pelican.http.url}/playlists/#{p.id}/m3u"
          )
      )
  )

let inputs.live =
  buffer(
    input.srt(
      port=config.server.srt.port,
      read_timeout=null(),
      write_timeout=null()
    )
  )
