let api.app = {}

def api.app.register(~method, ~path, handler) =
  def handle(request) =
    try
      handler(request)
    catch _ do
      api.responses.text(
        body="Internal Server Error",
        status=api.codes.internalservererror
      )
    end
  end

  harbor.http.register.simple(
    method=method,
    port=config.server.http.port,
    path,
    handle
  )
end
