def test_postgres_service(host):
    postgres = host.service("postgresql")

    #assert postgres.is_running
    #assert postgres.is_enabled
