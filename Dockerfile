#
# ElasticSearch Dockerfile
#
# https://github.com/umeice/elasticsearch
#
 
# Pull base image.
FROM dockerfile/java
 
# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.tar.gz && \
  tar xvzf elasticsearch-1.2.1.tar.gz && \
  rm -f elasticsearch-1.2.1.tar.gz && \
  mv /tmp/elasticsearch-1.2.1 /elasticsearch
RUN \
  /elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/2.2.0
RUN \
  /elasticsearch/bin/plugin -install mobz/elasticsearch-head
RUN \
  /elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf/1.2
RUN \
  /elasticsearch/bin/plugin -install knapsack -url http://xbib.org/repository/org/xbib/elasticsearch/plugin/elasticsearch-knapsack/1.2.0.0/elasticsearch-knapsack-1.2.0.0-plugin-s3.zip

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
