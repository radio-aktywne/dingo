let services.pelican.models = {}

def services.pelican.models.getplaylistrequest =
  def create(~id) =
    {id=id}
  end

  def serialize(model) =
    json.stringify(model)
  end

  def deserialize(data) =
    let json.parse (model : {id: string}) = data
    model
  end

  {create=create, serialize=serialize, deserialize=deserialize}
end

def services.pelican.models.getplaylistresponse =
  def create(~id, ~name) =
    {id=id, name=name}
  end

  def serialize(model) =
    json.stringify(model)
  end

  def deserialize(data) =
    let json.parse (model : {id: string, name: string}) = data
    model
  end

  {create=create, serialize=serialize, deserialize=deserialize}
end
