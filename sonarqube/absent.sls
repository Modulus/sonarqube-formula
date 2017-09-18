{% from 'sonarqube/map.jinja' import sonarqube with context %}
#include:
#  - postgresql.dropped

clear serivce:
  service.dead:
    - name: {{sonarqube.service_name}}
    - enable: False
    - require_in:
      - file: clear unzipped folder
      - user: remove sonar user
  file.absent:
    - name: {{sonarqube.service}}


clear sonarqube downloaded files:
  file.absent:
    - name: {{sonarqube.download_location}}/{{sonarqube.file_name}}

clear unzipped folder:
  file.absent:
    - name: {{sonarqube.install_folder}}

remove links:
  file.absent:
    - name:  {{sonarqube.link_folder}}

remove sonar user:
  user.absent:
    - name: {{sonarqube.user}}
