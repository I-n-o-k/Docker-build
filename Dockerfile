FROM ubuntu:focal

LABEL maintainer="WalkingDead-CI <lexaxx14@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8
ENV JAVA_OPTS=" -Xmx7G "
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV USE_CCACHE=1
ENV HOME=/root
WORKDIR /tmp

# Install Components
RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get install -yqq sudo tzdata locales python-is-python3 pigz tar rsync rclone aria2 ccache curl wget zip unzip lzip lzop zlib1g-dev xzdec xz-utils pixz p7zip-full p7zip-rar zstd libzstd-dev lib32z1-dev ffmpeg maven nodejs ca-certificates-java python-is-python3 pigz tar rsync rclone aria2 libncurses5 adb autoconf automake axel bc bison build-essential ccache clang cmake curl expat fastboot flex g++ g++-multilib gawk gcc gcc-multilib git gnupg gperf htop imagemagick locales libncurses5 lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev libsdl1.2-dev libssl-dev libtool libxml-simple-perl libxml2 libxml2-utils lsb-core lzip '^lzma.*' lzop maven nano ncftp ncurses-dev openssh-server patch patchelf pkg-config pngcrush pngquant python2.7 python-all-dev python-is-python3 re2c rclone rsync schedtool squashfs-tools subversion sudo tar texinfo tmate tzdata unzip w3m wget xsltproc zip zlib1g-dev zram-config zstd
RUN apt-get install tzdata
RUN apt-mark hold tzdata

# Settings System
RUN echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen
RUN /usr/sbin/locale-gen
RUN ln -snf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN echo Europe/Moscow > /etc/timezone
RUN apt install sudo git -yqq
RUN git config --global user.name WalkingDead-CI
RUN git config --global user.email lexaxx14@gmail.com

# Setting up udev rules for adb!
RUN sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
RUN sudo chmod 644 /etc/udev/rules.d/51-android.rules
RUN sudo chown root /etc/udev/rules.d/51-android.rules
RUN sudo systemctl restart udev

# Installing Repo
RUN sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
RUN sudo chmod a+rx /usr/local/bin/repo

# Install Android Tools
RUN apt-get install -y aria2 arj brotli cabextract cmake device-tree-compiler gcc g++ git liblz4-tool liblzma-dev libtinyxml2-dev lz4 mpack openjdk-11-jdk p7zip-full p7zip-rar python3 python3-pip rar sharutils unace unrar unzip uudeview xz-utils zip zlib1g-dev
RUN pacman -Syu --noconfirm android-tools aria2 arj brotli cabextract cmake dtc gcc git lz4 xz tinyxml2 p7zip python2-pip python-pip unrar sharutils unace zip unzip uudeview zip
RUN pip3 install backports.lzma docopt protobuf pycrypto zstandard

VOLUME ["/tmp/rom", "/tmp/ccache"]
