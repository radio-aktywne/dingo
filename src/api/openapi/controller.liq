let api.openapi.controller = {}

def api.openapi.controller.get(_) =
  docs = api.openapi.service.get()
  api.responses.html(body=docs, status=api.codes.ok)
end

api.app.register(method="GET", path="/openapi", api.openapi.controller.get)
