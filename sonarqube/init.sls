{% from 'sonarqube/map.jinja' import sonarqube with context %}

include:
  - sonarqube.user
#  - postgres.python
#  - postgres.server
#  - postgres.client
#  - postgres.manage

{% if sonarqube.install_open_jdk is defined and sonarqube.install_open_jdk == True %}
install java:
  pkg.installed:
    - name: {{sonarqube.jdk.package}}
    - refresh: True
    - require_in:
      - file: download sonarqube
{% endif %}

download sonarqube:
  file.managed:
    - makedirs: True
    - name: {{sonarqube.download_location}}/{{sonarqube.file_name}}
    - source: {{sonarqube.url}}
    - source_hash: {{sonarqube.hash_url}}
    - unless: ls {{sonarqube.download_location}}/{{sonarqube.file_name}}
    - require_in:
      - archive: unzip sonarqube
    - onfail:
      - cmd: curl sonarqube

curl sonarqube:
  cmd.run:
    - name: "curl -LOk {{sonarqube.url}} -o {{sonarqube.download_location}}/{{sonarqube.file_name}}"
    - cwd: {{sonarqube.download_location}}
    - unless: ls {{sonarqube.download_location}}/{{sonarqube.file_name}}
    - require_in:
      # - file: validate
      - archive: unzip sonarqube

# validate:
#   module.run:
#     - name: file.contains
#     - path: {{sonarqube.hash_url}}
#     - text: {{ [sonarqube.download_location, sonarqube.file_name] | join("/") | md5 }}
#     - require_in:
#       - archive: unzip sonarqube

unzip sonarqube:
  archive.extracted:
    - name: {{sonarqube.install_folder}}
    - source: {{sonarqube.download_location}}/{{sonarqube.file_name}}
    - user: {{sonarqube.user}}
    - group: {{sonarqube.user}}
    - unless: ls {{sonarqube.link_target}}
    - require_in:
      - file: create symlink

create symlink:
  file.symlink:
    - name:  {{sonarqube.link_folder}}
    - target: {{sonarqube.link_target}}
    - force: False
    - user: {{sonarqube.user}}
    - group: {{sonarqube.user}}
    - makedirs: True
    - require_in:
      - file: create service file

create service file:
  file.managed:
    - name: {{sonarqube.service}}
    - source: {{sonarqube.source}}
    - user: {{sonarqube.user}}
    - group: {{sonarqube.user}}
    - mode: 774
    - template: jinja
    - context:
      folder: {{sonarqube.link_folder}}
      user: {{sonarqube.user}}
      service_name: {{sonarqube.service_name}}
    - require_in:
      - servie: enable and start sonarqube service

config file:
  file.managed:
    - name: {{sonarqube.link_target}}/conf/sonar.properties
    - source: salt://sonarqube/files/sonar.properties
    - template: jinja
    - user: {{sonarqube.user}}
    - group: {{sonarqube.user}}
    #- require:
    #  - sls: sonarqube.user

enable and start sonarqube service:
  service.running:
    - name: {{sonarqube.service_name}}
    - enable: True
    - watch:
      - file: create service file
      - file: config file
