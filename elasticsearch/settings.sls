{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}

{% set version = salt['pillar.get']('elasticsearch:version') %}
{% if version >= 5 %}
  {% set major_version = 5 %}
{% else %}
  {% set pillar_major_version = 2 %}
{% endif %}

{% set elasticsearch = {} %}
{% do elasticsearch.update( { 
                              'version': version,
                              'major_version': major_version,
                            } ) %}
