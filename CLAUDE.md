# Bash Scripts dla Proxmox VMs

Repozytorium zawiera proste skrypty bashowe ułatwiające konfigurację maszyn wirtualnych na Proxmoxie. Skrypty automatyzują powtarzalne zadania administracyjne, przyspieszając start nowych VM-ek.

## Dostępne skrypty

### mysql_db_create.sh
Interaktywny skrypt do tworzenia bazy danych MySQL wraz z użytkownikiem. Automatycznie wykrywa, czy istnieje plik `/root/.my.cnf` z danymi dostępowymi.

```bash
./mysql_db_create.sh
```

### pgsql_db_create.sh
Skrypt do tworzenia bazy danych PostgreSQL z użytkownikiem.

```bash
./pgsql_db_create.sh <nazwa_bazy> <hasło>
```

### protect_nginx_site.sh
Dodaje ochronę hasłem (HTTP Basic Auth) do strony w nginx.

```bash
sudo ./protect_nginx_site.sh <nazwa_strony> <login> <hasło>
```

### create_app_user.sh
Tworzy użytkownika `app` z dostępem sudo i ustawia hasło.

```bash
sudo ./create_app_user.sh
```

## Wymagania

- Linux (testowane na Debian/Ubuntu)
- Odpowiednie uprawnienia (root dla niektórych skryptów)
- Zainstalowane: MySQL/MariaDB, PostgreSQL lub nginx (w zależności od używanego skryptu)
