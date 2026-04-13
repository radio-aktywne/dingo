let utils.url = {}

def utils.url.build(~host, ~path=null(), ~port=null(), ~scheme="http") =
  def pathify(value) =
    (value == "" or string.contains(prefix="/", value)) ? value : "/#{value}"
  end

  url = "#{scheme}://#{host}"
  url = null.case(port, fun () -> url, fun (p) -> "#{url}:#{p}")
  url = null.case(path, fun () -> url, fun (p) -> "#{url}#{pathify(p)}")

  url
end
