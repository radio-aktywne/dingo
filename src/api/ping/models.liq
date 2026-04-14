let api.ping.models = {}

def api.ping.models.pingrequest =
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

def api.ping.models.pingresponse =
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
