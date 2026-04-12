output.icecast(
  %mp3,
  host=config.quokka.icy.host,
  icy_metadata=constants.metadata.keys,
  icy_song=fun (_) -> null(),
  mount=config.quokka.icy.mount,
  password=config.quokka.icy.password,
  port=config.quokka.icy.port,
  user=config.quokka.icy.user,
  streams.main
)
