let config.pelican.http = {}

let config.pelican.http.host =
  utils.env.safeget(default="localhost", "DINGO__PELICAN__HTTP__HOST")
let config.pelican.http.path = utils.env.get("DINGO__PELICAN__HTTP__PATH")
let config.pelican.http.port =
  utils.parse.oint(
    utils.env.safeget(default="10200", "DINGO__PELICAN__HTTP__PORT")
  )
let config.pelican.http.scheme =
  utils.env.safeget(default="http", "DINGO__PELICAN__HTTP__SCHEME")
let config.pelican.http.url =
  utils.url.build(
    host=config.pelican.http.host,
    path=config.pelican.http.path,
    port=config.pelican.http.port,
    scheme=config.pelican.http.scheme
  )
