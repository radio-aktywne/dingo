let api.playlist.controller = {}

def api.playlist.controller.get(_) =
  try
    response = api.playlist.service.get()
    api.responses.json(
      status=api.codes.ok,
      body=api.playlist.models.getresponse.serialize(response)
    )
  catch error : [api.playlist.errors.notfound] do
    api.responses.text(status=api.codes.notfound, body=error.message)
  end
end

def api.playlist.controller.put(request) =
  try
    req = api.playlist.models.putrequest.deserialize(request.body())
    res = api.playlist.service.put(req)
    api.responses.json(
      status=api.codes.ok,
      body=api.playlist.models.putresponse.serialize(res)
    )
  catch error : [error.json] do
    api.responses.text(status=api.codes.badrequest, body=error.message)
  end
end

api.app.register(method="GET", path="/playlist", api.playlist.controller.get)
api.app.register(method="PUT", path="/playlist", api.playlist.controller.put)
