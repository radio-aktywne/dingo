let api.playlist.controller = {}

def api.playlist.controller.get(_) =
  try
    response = api.playlist.service.get()
    api.responses.json(
      body=api.playlist.models.getresponse.serialize(response),
      status=api.codes.ok
    )
  catch e : [api.playlist.errors.notfound] do
    api.responses.text(body=e.message, status=api.codes.notfound)
  end
end

def api.playlist.controller.put(request) =
  try
    req = api.playlist.models.putrequest.deserialize(request.body())
    res = api.playlist.service.put(req)
    api.responses.json(
      body=api.playlist.models.putresponse.serialize(res),
      status=api.codes.ok
    )
  catch e : [error.json, api.playlist.errors.badrequest] do
    api.responses.text(body=e.message, status=api.codes.badrequest)
  end
end

api.app.register(method="GET", path="/playlist", api.playlist.controller.get)
api.app.register(method="PUT", path="/playlist", api.playlist.controller.put)
