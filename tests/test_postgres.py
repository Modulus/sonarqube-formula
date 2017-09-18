def test_postgres_service(host):
    postgres = host.service("postgresql")

    assert postgres.is_running
    assert postgres.is_enabled

def test_postgres_port_and_localhost(host):
    socket = host.socket("tcp://127.0.0.1:5433")

    assert socket.is_listening


def test_postgresql_user(host):
    passwd = host.file("/etc/passwd")

    assert passwd.is_file
    assert passwd.user == "root"
    assert passwd.group == "root"
    assert passwd.contains("postgres:x")
