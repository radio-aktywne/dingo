let api.openapi.service = {}

def api.openapi.service.docs(_) =
  docs = file.contents("src/resources/openapi/docs.html")
  api.openapi.models.docsresponse.create(docs=docs)
end

def api.openapi.service.schema(_) =
  schema = file.contents("src/resources/openapi/schema.yaml")
  api.openapi.models.schemaresponse.create(schema=schema)
end
