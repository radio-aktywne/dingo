let api.playlist.models = {}

def api.playlist.models.getrequest =
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

def api.playlist.models.getresponse =
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

def api.playlist.models.putrequest =
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

def api.playlist.models.putresponse =
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

def api.playlist.models.deleterequest =
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

def api.playlist.models.deleteresponse =
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
