FROM gradle:5.3.1-jdk8

LABEL author="rayms.dev@gmail.com" 

USER root

# Install Android SDK.

WORKDIR /usr
RUN curl -L https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o sdk-tools-linux-4333796.zip
RUN unzip sdk-tools-linux-4333796.zip
RUN rm sdk-tools-linux-4333796.zip

RUN mkdir /usr/android_sdk
RUN mv ./tools  /usr/android_sdk/
WORKDIR  /usr/android_sdk
RUN mkdir /root/.android
RUN touch /root/.android/repositories.cfg
RUN yes | ./tools/bin/sdkmanager --licenses
RUN ./tools/bin/sdkmanager --update

ENV ANDROID_HOME=/usr/android_sdk
ENV PATH=$PATH:$ANDROID_HOME/tools
ENV PATH=$PATH:$ANDROID_HOME/platform-tools
ENV PATH=$PATH:$ANDROID_HOME/build-tools/27.0.3/

RUN ./tools/bin/sdkmanager \
    "extras;android;m2repository" \
    "build-tools;27.0.3" \
    "platforms;android-27"

# Install Node.js
RUN apt-get update
RUN apt-get install --yes curl gnupg2
RUN curl --silent --location https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install --yes nodejs
RUN apt-get install --yes build-essential

CMD ["/bin/bash"]