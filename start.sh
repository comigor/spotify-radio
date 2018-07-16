#!/bin/bash
echo 'Starting pulseaudio...'
su - user -c 'pulseaudio -D --exit-idle-time=-1'
sleep 2

echo 'Starting Icecast2...'
/etc/init.d/icecast2 start
sleep 2

# pulseaudio -vvv --exit-idle-time=-1
# pacmd load-module module-pipe-sink file=/audio/stream format=s16 rate=44100 channels=2
# pacmd load-module module-pipe-sink file=/audio/stream format=s16 rate=8192 channels=1

echo 'Starting spotifyd...'
su - user -c "spotifyd --username $SPOTIFY_USERNAME --password $SPOTIFY_PASSWORD"
sleep 2

# socat file:/audio/stream tcp-listen:12345

# rust:slim
# apt-get install build-essential pkg-config libalsa-ocaml-dev libssl-dev libpulse-dev

#cat /audio/stream | ffmpeg -i - -f mpegts udp://0.0.0.0:12345
#docker run -it --rm --name argh -p 12345:12345 -p 12345:12345/udp --entrypoint bash argh

echo 'Starting darkice...'
su - user -c 'darkice -c /home/user/darkice.cfg'
