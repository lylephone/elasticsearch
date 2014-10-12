#
# ElasticSearch Dockerfile
#
# https://github.com/umeice/elasticsearch
#

# Pull base image.
FROM dockerfile/java:oracle-java8

MAINTAINER @bungoume <bungoume@gmail.com>

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.tar.gz && \
  tar xvzf elasticsearch-1.3.4.tar.gz && \
  rm -f elasticsearch-1.3.4.tar.gz && \
  mv /tmp/elasticsearch-1.3.4 /elasticsearch

# Install Plugins.
RUN \
  /elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/2.3.0 && \
  /elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-icu/2.3.0 && \
  /elasticsearch/bin/plugin -install elasticsearch/elasticsearch-cloud-aws/2.3.0 && \
  /elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf && \
  /elasticsearch/bin/plugin -install elasticsearch/marvel/latest && \
  /elasticsearch/bin/plugin -install mobz/elasticsearch-head


# Update Ubuntu.
RUN \
  apt-get update && apt-get -y upgrade


# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
