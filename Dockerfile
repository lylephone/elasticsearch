#
# Elasticsearch Dockerfile
#
# https://github.com/umeice/elasticsearch
#

# Pull base image.
FROM elasticsearch:1.5

MAINTAINER @bungoume <bungoume@gmail.com>

# Install Plugins.
RUN \
  plugin -install elasticsearch/elasticsearch-analysis-kuromoji/2.5.0 && \
  plugin -install elasticsearch/elasticsearch-analysis-icu/2.5.0 && \
  plugin -install elasticsearch/elasticsearch-cloud-aws/2.5.0 && \
  plugin -install lmenezes/elasticsearch-kopf && \
  plugin -install elasticsearch/marvel/latest && \
  plugin -install mobz/elasticsearch-head

# Add elasticsearch.yml config
ADD config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9200 9300

CMD ["elasticsearch"]
