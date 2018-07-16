# Spotify Radio

Stream your Spotify collection

## What?

A docker image that creates a new device on Spotify (called "Daemon"), which streams what you're listening to Icecast.

It uses the excellent [spotifyd](https://github.com/Spotifyd/spotifyd).

## Why?

Spotify has an electron app that consumes gigabytes of RAM. I miss the time I used around 100MB at max to do the same.

So I've been looking for alternatives. Spotifyd came to the rescue but every time my computer went to sleep I had to restart it and recconect to my Daemon device on Spotify. So I've come up with the idea of dockerize it and let it live on my server, and I choose Icecast to stream it to my machine.

## Legal
Spotify Radio in licensed under MIT.

SPOTIFY is a trademark of Spotify AB.
