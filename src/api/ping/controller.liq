let api.ping.controller = {}

def api.ping.controller.ping(_) =
  req = api.ping.models.pingrequest.create()
  api.ping.service.ping(req)
  api.responses.empty(headers=[("Cache-Control", "no-cache")])
end

api.app.register(method="GET", path="/ping", api.ping.controller.ping)
