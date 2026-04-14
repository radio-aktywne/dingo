let api.ping.service = {}

def api.ping.service.ping(_) =
  api.ping.models.pingresponse.create()
end
