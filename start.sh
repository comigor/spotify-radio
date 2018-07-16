#!/bin/bash
echo 'Starting pulseaudio...'
su - user -c 'pulseaudio -D --exit-idle-time=-1'
sleep 2

echo 'Starting Icecast2...'
/etc/init.d/icecast2 start
sleep 2

echo 'Starting spotifyd...'
su - user -c "spotifyd --username $SPOTIFY_USERNAME --password $SPOTIFY_PASSWORD"
sleep 2

echo 'Starting darkice...'
su - user -c 'darkice -c /home/user/darkice.cfg'
