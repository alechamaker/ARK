FROM thmhoag/steamcmd:latest

USER root

RUN apt-get update && \
    apt-get install -y curl cron bzip2 perl-modules lsof libc6-i386 lib32gcc1 sudo

RUN curl -sL "https://raw.githubusercontent.com/FezVrasta/ark-server-tools/v1.6.54/netinstall.sh" | bash -s steam && \
    ln -s /usr/local/bin/arkmanager /usr/bin/arkmanager

COPY arkmanager/arkmanager.cfg /etc/arkmanager/arkmanager.cfg
COPY arkmanager/instance.cfg /etc/arkmanager/instances/main.cfg
COPY run.sh /home/steam/run.sh
COPY log.sh /home/steam/log.sh
COPY Game.ini /tmp/Game.ini
COPY GameUserSettings.ini /tmp/GameUserSettings.ini

RUN mkdir /ark && \
    chown -R steam:steam /home/steam/ /ark


RUN echo "%sudo   ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers && \
    usermod -a -G sudo steam && \
    touch /home/steam/.sudo_as_admin_successful

RUN chown steam /tmp

WORKDIR /home/steam
USER steam



EXPOSE 7777/tcp
EXPOSE 7777/udp
EXPOSE 7778/tcp
EXPOSE 7778/udp
EXPOSE 27015/tcp
EXPOSE 27015/udp

VOLUME /ark


ENTRYPOINT [ "./run.sh" ]
