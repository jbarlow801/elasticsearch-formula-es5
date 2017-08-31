kibana:
  pkg.latest:
    - refresh: True
  service.running:
    - enable: True
    - require:
      - /etc/kibana/kibana.yml

/etc/kibana/kibana.yml:
  file.managed:
    - source: salt://elasticsearch/files/kibana-yml
    - template: jinga
    - user: root
    - group: root
    - mode: 644

/es/logs/kibana:
  file.directory:
    - user: kibana
    - group: kibana
    - require:
      - pkg: kibana
