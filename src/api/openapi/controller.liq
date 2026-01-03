let api.openapi.controller = {}

def api.openapi.controller.get(_) =
  docs = api.openapi.service.get()
  api.responses.html(status=api.codes.ok, body=docs)
end

api.app.register(method="GET", path="/openapi", api.openapi.controller.get)
