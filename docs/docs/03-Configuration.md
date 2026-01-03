---
slug: /config
title: Configuration
---

## Environment variables

You can configure the service at runtime using various environment variables:

- `DINGO__PELICAN__HTTP__HOST` -
  host of the HTTP API of the pelican service
  (default: `localhost`)
- `DINGO__PELICAN__HTTP__PATH` -
  path of the HTTP API of the pelican service
  (default: ``)
- `DINGO__PELICAN__HTTP__PORT` -
  port of the HTTP API of the pelican service
  (default: `10200`)
- `DINGO__PELICAN__HTTP__SCHEME` -
  scheme of the HTTP API of the pelican service
  (default: `http`)
- `DINGO__QUOKKA__ICY__HOST` -
  host of the ICY API of the quokka service
  (default: `localhost`)
- `DINGO__QUOKKA__ICY__MOUNT` -
  mount point of the ICY API of the quokka service to send the audio to
  (default: `radio.mp3`)
- `DINGO__QUOKKA__ICY__PASSWORD` -
  password to authenticate with the ICY API of the quokka service
  (default: `password`)
- `DINGO__QUOKKA__ICY__PORT` -
  port of the ICY API of the quokka service
  (default: `10000`)
- `DINGO__QUOKKA__ICY__USER` -
  user to authenticate with the ICY API of the quokka service
  (default: `source`)
- `DINGO__SERVER__HTTP__PORT` -
  port to listen for HTTP connections
  (default: `10101`)
- `DINGO__SERVER__SRT__PORT`
  port to listen for SRT connections
  (default: `10100`)
- `DINGO__STATE__CACHE__TTL` -
  how long to cache the state in memory in seconds
  (default: `60`)
- `DINGO__STATE__STORE__PATH` -
  path to the file to store the state
  (default: `data/state.json`)
