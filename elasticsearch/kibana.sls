kibana:
  pkg.latest:
    - refresh: True
  service.running:
    - enable: True
    - require_in:
      - file: /etc/kibana/kibana.yml

/etc/kibana/kibana.yml:
  file.managed:
    - source: salt://elasticsearch/files/kibana-yml
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/es/kibana:
  file.directory:
    - user: kibana
    - group: kibana
    - require:
      - pkg: kibana
