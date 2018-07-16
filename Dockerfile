FROM ubuntu
RUN apt-get update && apt-get -y install pulseaudio alsa-utils darkice icecast2

RUN sed "s/^load-module module-console-kit/#load-module module-console-kit/" -i /etc/pulse/default.pa \
    && echo "load-module module-native-protocol-tcp auth-anonymous=1" >> /etc/pulse/default.pa \
    && sed "s/ENABLE=false/ENABLE=true/" -i /etc/default/icecast2 \
    && sed "s/hackme/prettybigpasswordthatnoonewouldguess/g" -i /etc/icecast2/icecast.xml \
    && sed "s/8000/20300/" -i /etc/icecast2/icecast.xml \
    && mkdir -p /audio \
    && chmod 0777 /audio \
    && useradd -u 1000 -m -d /home/user -s /bin/sh user \
    && usermod -aG audio user

ADD start.sh /bin/start.sh
ADD spotifyd /bin/spotifyd
ADD darkice.cfg /home/user/darkice.cfg

USER user
RUN mkdir -p /home/user/.config/spotifyd
ADD spotifyd.conf /home/user/.config/spotifyd/spotifyd.conf

USER root

EXPOSE 20300
ENTRYPOINT [ "/bin/start.sh" ]
