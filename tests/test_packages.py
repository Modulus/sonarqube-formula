def test_pkg_python(host):
    pkg = host.package("python")

    assert pkg.is_installed

def test_pkg_postgres(host):
    pkg = host.package("postgresql-9.6")

    assert pkg.is_installed
