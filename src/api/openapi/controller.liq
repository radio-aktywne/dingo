let api.openapi.controller = {}

def api.openapi.controller.docs(_) =
  req = api.openapi.models.docsrequest.create()
  res = api.openapi.service.docs(req)
  api.responses.html(body=res.docs, status=api.codes.ok)
end

def api.openapi.controller.schema(_) =
  req = api.openapi.models.schemarequest.create()
  res = api.openapi.service.schema(req)
  api.responses.yaml(body=res.schema, status=api.codes.ok)
end

api.app.register(method="GET", path="/openapi", api.openapi.controller.docs)
api.app.register(
  method="GET",
  path="/openapi/openapi.yaml",
  api.openapi.controller.schema
)
