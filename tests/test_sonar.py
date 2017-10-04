sonarqube_location = "/opt/sonarqube-6.5"

def test_sonar_user_present_in_passwd(host):
    passwd = host.file("/etc/passwd")

    assert passwd.is_file
    assert passwd.user == "root"
    assert passwd.group == "root"
    assert passwd.contains("sonar:x")

def test_port_9000_active(host):
    socket = host.socket("tcp://0.0.0.0:9000")

    assert socket.is_listening

def test_sonar_user_present(host):
    user = host.user("sonar")

    assert user.uid == 6666
    assert len(user.groups) == 1
    assert "sonar" in user.groups
    assert "/home/sonar" == user.home
    # User has no login shell
    assert user.shell == ""

def test_sonar_folders_present(host):
    folder = host.file(sonarqube_location)

    assert folder.exists
    assert folder.is_directory

def test_sonar_symlink_present(host):
    folder = host.file("/opt/sonarqube")

    assert folder.exists
    assert folder.is_symlink
    assert folder.linked_to == sonarqube_location
