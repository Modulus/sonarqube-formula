create user:
  user.present:
    - fullname: Sonar user
    - name: {{salt['pillar.get']('sonarqube:lookup:user')}}
    - password: {{salt['pillar.get']('sonarqube:lookup:password')}}
    - system: True
