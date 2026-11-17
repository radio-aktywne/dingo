let inputs = {}

let inputs.fallback = single(constants.paths.fallback)

let inputs.live =
  begin
    pending = ref(false)
    hard = ref(false)

    receiver =
      input.srt(
        listen_callback=fun (~hs_version:_, ~peeraddr:_, ~streamid, _) ->
          null.case(
            utils.srt.streamid.parse(streamid),
            fun () -> false,
            fun (parameters) ->
              begin
                mode = list.assoc(default="hard", "dingo_start", parameters)

                if
                  list.mem(mode, ["hard", "soft"])
                then
                  pending := true
                  hard := mode == "hard"

                  true
                else
                  false
                end
              end
          ),
        port=config.server.srt.port,
        read_timeout=null,
        write_timeout=null
      )

    # Leave headroom for the output clock to react before buffer drops audio
    live = buffer(buffer=0.05, max=config.inputs.live.buffer + 5., receiver)

    receiver.on_frame(
      before=false,
      synchronous=true,
      fun () ->
        if
          pending()
        then
          if hard() then ignore(live.seek(config.inputs.live.buffer + 5.)) end

          pending := false
        end
    )

    receiver.on_disconnect(
      synchronous=true,
      fun () ->
        begin
          hard := false
          pending := false
        end
    )

    live.{
      interruptible =
        fun () ->
          (hard() and not pending())
          or seconds_of_main(live.buffer_length()) >= config.inputs.live.buffer
    }
  end

let inputs.playlist =
  utils.source.variable(
    fun () -> state().playlist,
    fun (p) ->
      begin
        def reset() =
          s = state()
          let s.playlist = null
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
