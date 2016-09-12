#
# Elasticsearch Dockerfile
#
# https://github.com/umeice/elasticsearch
#

# Pull base image.
FROM elasticsearch:2.4

MAINTAINER @bungoume <bungoume@gmail.com>

# Install Plugins.
RUN \
  plugin install analysis-kuromoji && \
  plugin install analysis-icu && \
  plugin install cloud-aws && \
  plugin install lmenezes/elasticsearch-kopf
#  plugin install mobz/elasticsearch-head && \
#  plugin install marvel-agent && \

# Add elasticsearch.yml config
ADD config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9200 9300

CMD ["elasticsearch"]
