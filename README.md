# Spotify Radio

Stream your Spotify collection

## What?

A docker image that creates a new device on Spotify (called "Daemon"), which streams what you're listening to Icecast.

It uses the excellent [spotifyd](https://github.com/Spotifyd/spotifyd).

## How?

```
docker run --name spotify -p 20300:20300 -e "SPOTIFY_USERNAME=$USERNAME" -e "SPOTIFY_PASSWORD=$PASS" borges/spotify-radio
```

Then connect to the stream via `http://my.ip.address:20300/spotify`.

## Why?

Spotify has an electron app that consumes gigabytes of RAM. I miss the time I used around 100MB to do the same.

So I've been looking for alternatives. Spotifyd came to the rescue but every time my computer went to sleep I had to restart it and reconnect to my Daemon device on Spotify. So I've come up with the idea of dockerize it and let it live on my server, and I chose Icecast to stream it to my machine.

## Disclaimer

[spotifyd](https://github.com/Spotifyd/spotifyd) binary was compiled via `cargo build --release --features pulseaudio_backend` and was included here to accelerate building time. You should compile it by yourself.

## Legal
Spotify Radio in licensed under MIT.

SPOTIFY is a trademark of Spotify AB.
