FROM ubuntu
RUN apt-get update && apt-get -y install pulseaudio socat alsa-utils ffmpeg vim darkice icecast2

RUN sed 's/^load-module module-console-kit/#load-module module-console-kit/' -i /etc/pulse/default.pa \
    && echo 'load-module module-native-protocol-tcp auth-anonymous=1' >> /etc/pulse/default.pa \
    && sed 's/ENABLE=false/ENABLE=true/' -i /etc/default/icecast2 \
    && sed 's/hackme/prettybigpasswordthatnoonewouldguess/g' -i /etc/icecast2/icecast.xml
    # && sed 's/RUN=no/RUN=yes/' -i /etc/default/darkice \
    # && sed 's/USER=nobody/USER=user/' -i /etc/default/darkice \
    # && sed 's/GROUP=nogroup/GROUP=audio/' -i /etc/default/darkice
    # && echo 'load-module module-switch-on-connect' >> /etc/pulse/default.pa \

RUN mkdir -p /audio && touch /audio/.do_not_delete && chmod 0777 /audio

RUN useradd -u 1000 -m -d /home/user -s /bin/sh user && \
    usermod -aG audio user

ADD start.sh /bin/start.sh
ADD spotifyd /bin/spotifyd
ADD darkice.cfg /home/user/darkice.cfg
# ADD darkice /etc/init.d/darkice

# RUN update-rc.d -f darkice remove
# RUN update-rc.d darkice defaults 99
# RUN update-rc.d icecast2 enable
# RUN update-rc.d darkice enable

WORKDIR /home/user
USER user

RUN mkdir -p /home/user/.config/spotifyd
ADD spotifyd.conf /home/user/.config/spotifyd/spotifyd.conf

USER root

EXPOSE 8000

ENTRYPOINT [ "/bin/start.sh" ]
# ENTRYPOINT [ "pulseaudio" "-D" "--exit-idle-time=-1" "&&" "pacmd" "load-module" "module-pipe-sink" "file=/dev/audio/stream" "format=s16" "rate=44100" "channels=2" "&&" "socat" "file:/dev/audio/stream" "tcp-listen:12345" ]
