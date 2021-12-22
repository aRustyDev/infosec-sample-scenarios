FROM kalilinux/kali:latest AS build

ARG KALI_DESKTOP=xfce
# Install basic packages
RUN apt update && DEBIAN_FRONTEND='noninteractive' apt install -y \
	kali-desktop-xfce \
    dbus-x11 \
	&& DEBIAN_FRONTEND='noninteractive' apt-get purge -y pm-utils xscreensaver* 

ENV DISPLAY :1
ENV KALI_DESKTOP ${KALI_DESKTOP}

# Install VNC
RUN apt-get install -y x11vnc xvfb \
	&& mkdir ~/.vnc \
	&& x11vnc -storepasswd 1234 ~/.vnc/passwd

# Install most common packages
RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y \
    burpsuite \
    firefox-esr \
    gedit \
    hydra \
    hashcat \
    iproute2 \
    john \
    metasploit-framework \
    nano \
    netcat-openbsd \
    nmap \
    sqlmap \
    vim \
    wireshark

# Install vscode
RUN apt install -y curl gpg software-properties-common apt-transport-https \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list \
    && apt update \
    && apt install -y code

# The default term, qTerminal, doesn't recognize bash as the default shell
# Set xfce4-terminal to be the default terminal instead. 
RUN apt install -y xfce4-terminal
RUN chsh -s /bin/bash \
    && mkdir -p /root/.config/xfce4 \
    && echo 'TerminalEmulator=xfce4-terminal' > /root/.config/xfce4/helpers.rc


FROM build

# The power manager xfce panel plugin fails on platform, replace the config with one that doesn't include that plugin
COPY xfce4 /root/.config/xfce4

COPY entrypoint.sh /entrypoint.sh
RUN chmod 744 entrypoint.sh
COPY ./.bashrc /root/.bashrc

# bash-log code
COPY bash-log /usr/local/bash-log

RUN cp /usr/local/bash-log/bash-log /bin/bash-log \
    && chmod 755 /bin/bash-log \
    && echo "/bin/bash-log" >> /etc/shells \
    && touch /var/log/bash-log \
    && chmod 666 /var/log/bash-log

RUN cp -f /usr/local/bash-log/script $(which script) || cp /usr/local/bash-log/script /bin/script

RUN chmod 755 /usr/local/bash-log/setup.sh \
    && /usr/local/bash-log/setup.sh root

EXPOSE 5900

# ENTRYPOINT ["/entrypoint.sh"]
