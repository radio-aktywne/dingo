let api.app = {}

def api.app.register(~method, ~path, handler) =
  def handle(request) =
    try
      handler(request)
    catch _ do
      api.responses.text(
        status=api.codes.internalservererror,
        body="Internal Server Error"
      )
    end
  end

  harbor.http.register.simple(
    port=config.server.http.port,
    method=method,
    path,
    handle
  )
end
