let config.quokka.icy = {}

let config.quokka.icy.host =
  utils.env.safeget(default="localhost", "DINGO__QUOKKA__ICY__HOST")
let config.quokka.icy.mount =
  utils.env.safeget(default="radio.mp3", "DINGO__QUOKKA__ICY__MOUNT")
let config.quokka.icy.password =
  utils.env.safeget(default="password", "DINGO__QUOKKA__ICY__PASSWORD")
let config.quokka.icy.port =
  utils.parse.int(
    utils.env.safeget(default="10000", "DINGO__QUOKKA__ICY__PORT")
  )
let config.quokka.icy.user =
  utils.env.safeget(default="source", "DINGO__QUOKKA__ICY__USER")
