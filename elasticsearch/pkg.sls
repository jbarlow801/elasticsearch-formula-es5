include:
  - elasticsearch.repo

{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}
{% from "elasticsearch/settings.sls" import elasticsearch with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch_map.pkg }}
    {% if elasticsearch.version %}
    - version: 5.5.2
    {% endif %}
    - require:
      - sls: elasticsearch.repo

openjdk8jdk:
  pkg.latest:
    - name: openjdk-8-jdk

/etc/java-8-openjdk/security/java.policy:
  file.append:
    - text:
      - 'grant { permission javax.management.MBeanTrustPermission "register"; };'
      - 'grant { permission java.security.AllPermission; };'
    - require:
      - pkg: openjdk8jdk

/etc/security/limits.conf:
  file.append:
    - text:
      - elasticsearch soft memlock unlimited
      - elasticsearch hard memlock unlimited

/usr/lib/systemd/system/elasticsearch.service:
  file.replace:
    - pattern: "#LimitMEMLOCK=infinity"
    - repl: "LimitMEMLOCK=infinity"
    - prepend_if_not_found: True

