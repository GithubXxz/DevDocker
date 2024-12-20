FROM ubuntu:jammy

ENV container docker

# Enable systemd.
RUN apt update ; \
    apt install -y systemd systemd-sysv ; \
    apt clean ; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ; \
    cd /lib/systemd/system/sysinit.target.wants/ ; \
    ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 ; \
    rm -f /lib/systemd/system/multi-user.target.wants/* ; \
    rm -f /etc/systemd/system/*.wants/* ; \
    rm -f /lib/systemd/system/local-fs.target.wants/* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* ; \
    rm -f /lib/systemd/system/basic.target.wants/* ; \
    rm -f /lib/systemd/system/anaconda.target.wants/* ; \
    rm -f /lib/systemd/system/plymouth* ; \
    rm -f /lib/systemd/system/systemd-update-utmp*

    
COPY config/etc/apt/sources.list /etc/apt/sources.list
RUN apt update && apt install -y --no-install-recommends \
    ca-certificates && update-ca-certificates

RUN apt install -y --no-install-recommends \
    openssh-server \
    sudo locales \
    neofetch tldr \
    net-tools curl wget telnet iputils-ping \
    unzip p7zip-full \
    fd-find ripgrep \
    tmux \
    zsh \
    vim 


# install compiler toolchain
RUN apt update && apt install -y --no-install-recommends \
    gcc \
    libstdc++-12-dev \
    cmake \
    ninja-build 

COPY config/etc/apt/sources.list.d/llvm.list /etc/apt/sources.list.d/llvm.list
RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
# RUN apt update && apt install -y --no-install-recommends \
#     clang-18 \
#     lld-18 \
#     clangd-18 \
#     lldb-18

RUN apt clean && rm -rf /var/lib/apt/lists/*

# set the time zone
ENV TZ=Asia/Shanghai
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd -m -s $(which zsh) ryukk && \
    echo 'ryukk:Ryukk511322.' | chpasswd && \
    usermod -aG sudo ryukk

RUN mkdir /var/run/sshd && \
    echo 'PermitRootLogin no' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'AllowUsers ryukk' >> /etc/ssh/sshd_config

USER ryukk
WORKDIR /home/ryukk

# install zoxide
RUN curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# configure user ssh and expose SSH service port
COPY --chown=ryukk:ryukk config/home/ryukk/.ssh .ssh
COPY --chown=ryukk:ryukk config/home/ryukk/.zshrc .zshrc
COPY --chown=ryukk:ryukk config/home/ryukk/.vimrc .vimrc
COPY --chown=ryukk:ryukk config/home/ryukk/.efficient_scripts.sh .efficient_scripts.sh
COPY --chown=ryukk:ryukk config/home/ryukk/.zimrc .zimrc
COPY --chown=ryukk:ryukk config/home/ryukk/.tmux.conf .tmux.conf
COPY --chown=ryukk:ryukk config/home/ryukk/.config .config

USER root
# COPY init_script.sh /etc/init.d/
# COPY service/remove-nologin.service /etc/systemd/system/remove-nologin.service
EXPOSE 22
VOLUME [ "/sys/fs/cgroup" ]
STOPSIGNAL SIGRTMIN+3

CMD ["/lib/systemd/systemd"]