let api.playlist.service = {}

def api.playlist.service.get() =
  def notfound() =
    error.raise(
      api.playlist.errors.notfound,
      "Playlist data not found."
    )
  end

  def check(id) =
    request = services.pelican.models.getplaylistrequest.create(id=id)

    try
      services.pelican.service.getplaylist(request)
    catch _ : [services.pelican.errors.playlistnotfound] do
      s = state()
      let s.playlist = null()
      state := s

      notfound()
    end
  end

  def found(playlist) =
    check(playlist.id)
    api.playlist.models.getresponse.create(id=playlist.id)
  end

  playlist = state().playlist
  null.case(playlist, notfound, found)
end

def api.playlist.service.put(request) =
  def fetch(id) =
    request = services.pelican.models.getplaylistrequest.create(id=id)

    try
      services.pelican.service.getplaylist(request)
    catch _ : [services.pelican.errors.playlistnotfound] do
      error.raise(
        api.playlist.errors.badrequest,
        "Playlist #{id} does not exist."
      )
    end
  end

  playlist = fetch(request.id)

  s = state()
  let s.playlist = {id=playlist.id}
  state := s

  api.playlist.models.putresponse.create(id=playlist.id)
end
