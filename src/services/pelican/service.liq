let services.pelican.service = {}

def services.pelican.service.getplaylist(request) =
  response = http.get("#{config.pelican.http.url}/playlists/#{request.id}")

  if
    response.status_code == 404
  then
    error.raise(
      services.pelican.errors.playlistnotfound,
      "Playlist #{request.id} not found."
    )
  end

  services.pelican.models.getplaylistresponse.deserialize(response)
end
