
FROM gocd/gocd-agent-ubuntu-18.04:v20.1.0

USER root

RUN apt-get update &&\
apt-get install -y --no-install-recommends gnupg2 &&\
rm -rf /var/lib/apt/lists/*


RUN curl -O https://download.java.net/java/GA/jdk13.0.2/d4173c853231432d94f001e99d882ca7/8/GPL/openjdk-13.0.2_linux-x64_bin.tar.gz &&\
tar xvf openjdk-13.0.2_linux-x64_bin.tar.gz &&\
mv openjdk-13.0.2_linux-x64_bin.tar.gz /opt/jdk-13

RUN touch /etc/profile.d/jdk13.sh &&\
echo "export JAVA_HOME=/opt/jdk-13" >> /etc/profile.d/jdk13.sh &&\
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile.d/jdk13.sh

RUN apt-get update &&\
apt-get install -y --no-install-recommends maven &&\
rm -rf /var/lib/apt/lists/*