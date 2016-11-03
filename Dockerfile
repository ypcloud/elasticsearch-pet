FROM elasticsearch:5.0.0

ADD http://repo1.maven.org/maven2/io/fabric8/elasticsearch-cloud-kubernetes/5.0.0/elasticsearch-cloud-kubernetes-5.0.0.zip /tmp/elasticsearch-cloud-kubernetes-5.0.0.zip
RUN elasticsearch-plugin install file:///tmp/elasticsearch-cloud-kubernetes-5.0.0.zip --batch
# RUN bin/plugin install lmenezes/elasticsearch-kopf/v2.1.2

ENV BOOTSTRAP_MLOCKALL=false NODE_DATA=true NODE_MASTER=true ES_JAVA_OPTS=-Djava.net.preferIPv4Stack=true

# pre-stop-hook.sh and dependencies
RUN apt-get update && apt-get install -y \
    jq \
    curl \
 && rm -rf /var/lib/apt/lists/*
COPY pre-stop-hook.sh /pre-stop-hook.sh

ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
