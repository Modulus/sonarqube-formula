def test_sonar_user(host):
    passwd = host.file("/etc/passwd")

    assert passwd.is_file
    assert passwd.user == "root"
    assert passwd.group == "root"
    assert passwd.contains("sonar:x")

def test_port_9000(host):
    socket = host.socket("tcp://0.0.0.0:9000")

    assert socket.is_listening
