FROM gocd/gocd-agent-ubuntu-18.04:v20.1.0

LABEL MAINTAINER="sajiduk26" \
 VERSION="0.2" \
 DESCRIPTION="ubuntu gocd agent"

USER root

# ENV container docker

RUN curl -O https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz &&\
tar xvf openjdk-13_linux-x64_bin.tar.gz &&\
cp jdk-13 -R /opt/java/ &&\
rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/opt/java/ \
    PATH="/opt/java/bin:$PATH"
# RUN tee jdk13env.sh <<EOF \
# export JAVA_HOME=$JAVA_HOME \
# export PATH=\$PATH\$JAVA_HOME/bin \
# EOF

# RUN cat etc/profile.d/jdk13env.sh

# RUN source jdk13env.sh
# RUN echo $PATH

# RUN echo $JAVA_HOME &&\
# java --version

RUN apt-get update &&\
apt-get install -y --no-install-recommends gnupg2 maven


# # apt-get update && apt-get install -y --no-install-recommends curl &&\ 
# # curl -O https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz &&\
# # # tar xvf openjdk-13_linux-x64_bin.tar.gz --directory /opt/jdk-13 &&\
# # tar xvf openjdk-13_linux-x64_bin.tar.gz && ls -a && cp jdk-13 -R /opt/ && cd /opt/jdk-13 && ls -a &&\
# # export JAVA_HOME=/opt/jdk-13/ &&\
# # echo $JAVA_HOME
# # # && cd /opt/jdk-13 &&\
# # # mkdir /opt/jdk-13 && cd /opt/jdk-13 && pwd