FROM gitlab/gitlab-runner:latest

RUN apt update && \
    apt install python-pip -y && \
    apt install python3 -y && \
    apt install unzip -y && \
    pip install awscli && \
    pip install boto3

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip && \
    unzip sonar-scanner-cli-3.3.0.1492-linux.zip -d /opt/sonar-scanner/ && \
    cd /opt/sonar-scanner/sonar-scanner-3.3.0.1492-linux/ && \
    mv * ../ && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner

RUN apt update && \
    apt install ruby -y && \
    gem install cfn-nag

CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
