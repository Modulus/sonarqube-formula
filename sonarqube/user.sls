create user:
  user.present:
  #  - uid: {{salt['pillar.get']('sonarqube:lookup:user_uid')}}
    - fullname: Sonar user
    - name: {{salt['pillar.get']('sonarqube:lookup:user')}}
    - password: {{salt['pillar.get']('sonarqube:lookup:password')}}
    - system: True
