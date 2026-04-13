output.icecast(
  format="audio/ogg",
  host=config.quokka.icy.host,
  mount="#{config.quokka.icy.mount}.opus",
  password=config.quokka.icy.password,
  port=config.quokka.icy.port,
  user=config.quokka.icy.user,
  %ffmpeg(
    format = "ogg",
    %audio(b = "256k", codec = "libopus", samplerate = 48000)
  ),
  streams.main
)
