---
slug: /usage
title: Usage
---

## Ping

You can check the status of the service
by sending a `GET` request to the `/ping` endpoint.
The service should respond with a `204 No Content` status code.

For example, you can use `curl` to do that:

```sh
curl --request GET http://localhost:10101/ping
```

## Sending live audio

You can send live audio using the
[`SRT`](https://www.haivision.com/products/srt-secure-reliable-transport)
protocol.

You can use any audio codec and container,
but we recommend using [`Opus`](https://opus-codec.org) and
[`Ogg`](https://www.xiph.org/ogg) respectively.
They are free and open source, focused on quality and efficiency,
and support embedding metadata into the stream.

For example, you can use [`Liquidsoap`](https://www.liquidsoap.info) for that:

```sh
liquidsoap 'output.srt(host="127.0.0.1", port=10100, %ogg(%opus), sine())'
```

Alternatively, you can use [`ffmpeg`](https://ffmpeg.org) to do the same:

```sh
ffmpeg -re -f lavfi -i sine -c libopus -f ogg srt://127.0.0.1:10100
```

## Managing playlists

You can manage currently used playlist using the `/playlist` endpoint.
You can use the following HTTP methods:

- `GET` to retrieve the current playlist data
- `PUT` to update the current playlist data

For example, to change the playlist to use a different one,
you can use [`curl`](https://curl.se)
to send a `PUT` request to the `/playlist` endpoint:

```sh
curl \
    --request PUT \
    --header "Content-Type: application/json" \
    --data '{"id": "123e4567-e89b-12d3-a456-426614174000"}' \
    http://localhost:10101/playlist
```

## OpenAPI

You can view the [`OpenAPI`](https://www.openapis.org)
documentation made with [`Redocly`](https://redocly.com)
by navigating to the `/openapi` endpoint in your browser.
