#!/bin/bash

# Sprawdź, czy podano odpowiednią liczbę argumentów
if [ "$#" -ne 2 ]; then
    echo "Użycie: $0 <nazwa_bazy> <hasło>"
    exit 1
fi

NAZWA_BAZY=$1
HASLO=$2
NAZWA_BAZY_DB="`${NAZWA_BAZY}`.`db`"

# Tworzenie użytkownika i bazy danych w PostgreSQL
sudo -u postgres psql <<EOF
CREATE ROLE ${NAZWA_BAZY} WITH LOGIN PASSWORD '${HASLO}';
CREATE DATABASE ${NAZWA_BAZY_DB} OWNER ${NAZWA_BAZY};
GRANT ALL PRIVILEGES ON DATABASE ${NAZWA_BAZY_DB} TO ${NAZWA_BAZY};
EOF

# Sprawdź, czy operacja się powiodła
if [ $? -eq 0 ]; then
    echo "Baza danych '${NAZWA_BAZY_DB}' i użytkownik '${NAZWA_BAZY}' zostały pomyślnie utworzone."
else
    echo "Wystąpił błąd podczas tworzenia bazy danych lub użytkownika."
fi