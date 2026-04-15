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

For example, you can use [`ffmpeg`](https://ffmpeg.org) for that:

```sh
ffmpeg \
    -re \
    -f lavfi \
    -i sine \
    -c libopus \
    -f ogg \
    -ar 48000 \
    -b:a 256k \
    -metadata title=test \
    srt://127.0.0.1:10100
```

## Managing playlists

You can manage the currently used playlist using the `/playlist` endpoint.
You can use the following HTTP methods:

- `GET` to retrieve the current playlist
- `PUT` to update the current playlist
- `DELETE` to remove the current playlist

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
documentation made with [`Scalar`](https://scalar.com)
by navigating to the `/openapi` endpoint in your browser.

You can also download the specification in YAML format
by sending a `GET` request to the `/openapi/openapi.yaml` endpoint.

For example, you can use `curl` to do that:

```sh
curl --request GET http://localhost:10101/openapi/openapi.yaml
```
