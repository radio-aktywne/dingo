let inputs = {}

let inputs.fallback = single(constants.paths.fallback)

let inputs.live =
  buffer(
    input.srt(
      port=config.server.srt.port,
      read_timeout=null(),
      write_timeout=null()
    )
  )

let inputs.playlist =
  utils.source.variable(
    fun () -> state().playlist,
    fun (p) ->
      begin
        def reset() =
          s = state()
          let s.playlist = null()
          state := s
        end

        def check(p) =
          request = services.pelican.models.getplaylistrequest.create(id=p.id)

          try
            services.pelican.service.getplaylist(request)
          catch _ : [services.pelican.errors.playlistnotfound] do
            reset()
          end
        end

        def play(p) =
          playlist(
            loop=true,
            max_fail=3,
            mode="normal",
            on_reload=fun (_) ->
              null.case(
                state().playlist,
                fun () -> (),
                fun (sp) -> if sp.id == p.id then check(sp) end
              ),
            prefetch=3,
            reload=60,
            reload_mode="seconds",
            "#{config.pelican.http.url}/playlists/#{p.id}/m3u"
          )
        end

        utils.source.optional(p, play)
      end
  )
