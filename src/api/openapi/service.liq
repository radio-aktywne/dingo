let api.openapi.service = {}

def api.openapi.service.get =
  source = "openapi/schema.yaml"
  target = "openapi/docs.html"

  cached = ref("")

  def handle() =
    current = file.contents(source)

    if
      not file.exists(target) or current != cached()
    then
      if
        process.test(
          process.quote.command(
            args=["build-docs", "--output", target, source],
            "redocly"
          )
        )
      then
        cached := current
      else
        error.raise(
          api.openapi.errors.generate,
          "Failed to generate OpenAPI docs."
        )
      end
    end

    file.contents(target)
  end

  handle
end
