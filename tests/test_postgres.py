import psycopg2


def test_postgres_service_enabled_and_running(host):
    postgres = host.service("postgresql")

    assert postgres.is_running
    assert postgres.is_enabled

def test_postgres_port_and_localhost_active(host):
    socket = host.socket("tcp://127.0.0.1:5433")

    assert socket.is_listening

#def test_sonar_qube_db_exist():
#    conn = psycopg2.connect(host="localhost", port="5433", dbname="sonar", user="sonar", password="nokograier")

#    cur = conn.cursor()
#    cur.execute("select * from information_schema.tables where table_name=%s", ('mytable',))
#    assert True == bool(cur.rowcount)


def test_postgresql_user_present_in_passwd(host):
    passwd = host.file("/etc/passwd")

    assert passwd.is_file
    assert passwd.user == "root"
    assert passwd.group == "root"
    assert passwd.contains("postgres:x")

def test_postgresql_user_present(host):
    user = host.user("postgres")

    assert len(user.groups) == 2
    assert "postgres" in user.groups
    assert "ssl-cert" in user.groups
    assert "/var/lib/postgresql" == user.home
    assert user.shell == "/bin/bash"
