let api.responses = {}

def api.responses.http(~body, ~headers=[], ~status) =
  http.response(data=body, headers=headers, status_code=status)
end

def api.responses.empty(~headers=[]) =
  api.responses.http(body="", headers=headers, status=api.codes.nocontent)
end

def api.responses.html(~body, ~headers=[], ~status) =
  api.responses.http(
    body=body,
    headers=list.append(headers, [("Content-Type", "text/html")]),
    status=status
  )
end

def api.responses.json(~body, ~headers=[], ~status) =
  api.responses.http(
    body=body,
    headers=list.append(headers, [("Content-Type", "application/json")]),
    status=status
  )
end

def api.responses.text(~body, ~headers=[], ~status) =
  api.responses.http(
    body=body,
    headers=list.append(headers, [("Content-Type", "text/plain")]),
    status=status
  )
end
