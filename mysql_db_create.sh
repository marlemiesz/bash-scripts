#!/bin/sh

if [ -f /root/.my.cnf ]; then
        echo "Please enter the NAME of the new MySQL database! (example: database1)"
        read dbname
        echo "Please enter the MySQL database CHARACTER SET! (example: latin1, utf8, ...)"
        echo "Enter utf8 if you don't know what you are doing"
        read charset
        echo "Creating new MySQL database..."
        mysql -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
        echo "Database successfully created!"
        echo "Showing existing databases..."
        mysql -e "show databases;"
        echo ""
        echo "Please enter the NAME of the new MySQL database user! (example: user1)"
        read username
        echo "Please enter the PASSWORD for the new MySQL database user!"
        echo "Note: password will be hidden when typing"
        read userpass
        echo "Creating new user..."
        mysql -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
        echo "User successfully created!"
        echo ""
        echo "Granting ALL privileges on ${dbname} to ${username}!"
        mysql -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
        mysql -e "FLUSH PRIVILEGES;"
        echo "You're good now :)"
        exit

else
        echo "Please enter root user MySQL password!"
        echo "Note: password will be hidden when typing"
        read rootpasswd
        echo "Please enter the NAME of the new MySQL database! (example: database1)"
        read dbname
        echo "Please enter the MySQL database CHARACTER SET! (example: latin1, utf8, ...)"
        echo "Enter utf8 if you don't know what you are doing"
        read charset
        echo "Creating new MySQL database..."
        mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
        echo "Database successfully created!"
        echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;"
        echo ""
        echo "Please enter the NAME of the new MySQL database user! (example: user1)"
        read username
        echo "Please enter the PASSWORD for the new MySQL database user!"
        echo "Note: password will be hidden when typing"
        read userpass
        echo "Creating new user..."
        mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
        mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@'%' IDENTIFIED BY '${userpass}';"
        echo "User successfully created!"
        echo ""
        echo "Granting ALL privileges on ${dbname} to ${username}!"
        mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
        mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'%';"
        mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
        echo "You're good now :)"
        exit
fi
