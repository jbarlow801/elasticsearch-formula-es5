include:
  - elasticsearch.pkg

{%- if salt['pillar.get']('elasticsearch:config') %}
elasticsearch_cfg:
  file.serialize:
    - name: /etc/elasticsearch/elasticsearch.yml
    - dataset_pillar: elasticsearch:config
    - formatter: yaml
    - user: root
    - require:
      - sls: elasticsearch.pkg
{%- endif %}

{% set data_dir = salt['pillar.get']('elasticsearch:config:path.data') %}
{% set log_dir = salt['pillar.get']('elasticsearch:config:path.logs') %}

{% for dir in (data_dir, log_dir) %}
{% if dir %}
{{ dir }}:
  file.directory:
    - user: elasticsearch
    - group: elasticsearch
    - mode: 0700
    - makedirs: True
    - require_in:
      - service: elasticsearch
{% endif %}
{% endfor %}

{%- if salt['pillar.get']('elasticsearch:jvmoptions') %}
jvm_options:
  file.serialize:
    - name: /etc/elasticsearch/jvm.options
    - dataset_pillar: elasticsearch:jvmoptions
    - formatter: yaml
    - -user: root
    - require:
      - sls: elasticsearch.pkg
{% - endif %}
