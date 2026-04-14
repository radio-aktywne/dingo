let api.openapi.models = {}

def api.openapi.models.docsrequest =
  def create() =
    {}
  end

  def serialize(model) =
    json.stringify(model)
  end

  def deserialize(data) =
    let json.parse (model : {}) = data
    model
  end

  {create=create, serialize=serialize, deserialize=deserialize}
end

def api.openapi.models.docsresponse =
  def create(~docs) =
    {docs=docs}
  end

  def serialize(model) =
    json.stringify(model)
  end

  def deserialize(data) =
    let json.parse (model : {docs: string}) = data
    model
  end

  {create=create, serialize=serialize, deserialize=deserialize}
end

def api.openapi.models.schemarequest =
  def create() =
    {}
  end

  def serialize(model) =
    json.stringify(model)
  end

  def deserialize(data) =
    let json.parse (model : {}) = data
    model
  end

  {create=create, serialize=serialize, deserialize=deserialize}
end

def api.openapi.models.schemaresponse =
  def create(~schema) =
    {schema=schema}
  end

  def serialize(model) =
    json.stringify(model)
  end

  def deserialize(data) =
    let json.parse (model : {schema: string}) = data
    model
  end

  {create=create, serialize=serialize, deserialize=deserialize}
end
