FROM gocd/gocd-agent-docker-dind:v20.1.0

USER root

ENV MAVEN_VERSION 3.6.0
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget https://apache.mirrors.nublue.co.uk/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
  tar -zxvf apache-maven-3.6.3-bin.tar.gz && \
  rm apache-maven-3.6.3-bin.tar.gz && \
  mv apache-maven-3.6.3 /usr/lib/mvn

ENV JAVA_VERSION jdk-13.0.2+8

RUN set -eux; \
    apk add --no-cache --virtual .fetch-deps curl; \
    ARCH="$(apk --print-arch)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         ESUM='0e6081cb51f8a6f3062bef4f4c45dbe1fccfd3f3b4b5d52522a3edb76581e3af'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jdk_aarch64_linux_hotspot_13.0.2_8.tar.gz'; \
         ;; \
       armhf|armv7l) \
         ESUM='9beec080f2b2a7f6883b024272f4e8d5a0b027325e83647be318215781af1d1a'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jdk_arm_linux_hotspot_13.0.2_8.tar.gz'; \
         ;; \
       ppc64el|ppc64le) \
         ESUM='fb3362e34aac091a4682394d20dcdc3daea51995d369d62c28424573e0fc04aa'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jdk_ppc64le_linux_hotspot_13.0.2_8.tar.gz'; \
         ;; \
       s390x) \
         ESUM='1b9e7cd7fdde10fe3534988ef58c36f132b12f814503a034461c95735057467f'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jdk_s390x_linux_hotspot_13.0.2_8.tar.gz'; \
         ;; \
       amd64|x86_64) \
         ESUM='9ccc063569f19899fd08e41466f8c4cd4e05058abdb5178fa374cb365dcf5998'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jdk_x64_linux_hotspot_13.0.2_8.tar.gz'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    apk del --purge .fetch-deps; \
    rm -rf /var/cache/apk/*; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"