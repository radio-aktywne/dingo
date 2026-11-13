let utils.srt.streamid = {}

def utils.srt.streamid.parse(streamid) =
  streamid = null.default(streamid, fun () -> "")

  if
    streamid == ""
  then
    []
  elsif
    not string.contains(prefix="#!::", streamid)
  then
    null
  else
    content = string.replace(pattern="^#!::", fun (_) -> "", streamid)
    fields = content == "" ? [] : (string.split(separator=",", content))

    if
      list.for_all(fun (field) -> r/^[^=,{}]+=[^,{}]+$/.test(field), fields)
    then
      list.map(fun (field) -> string.split.first(separator="=", field), fields)
    else
      null
    end
  end
end
