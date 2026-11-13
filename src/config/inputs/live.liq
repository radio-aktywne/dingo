let config.inputs.live = {}

let config.inputs.live.buffer =
  utils.parse.float(
    utils.env.safeget(default="900", "DINGO__INPUTS__LIVE__BUFFER")
  )
