#!/bin/sh

# Check if script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Check if the site name, login and password has provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: protect_nginx_site.sh <site_name> <login> <password>"
    exit 1
fi

# Generate .htpasswd file
htpasswdFile="/etc/nginx/.htpasswd$1"
# Delete the file if it already exists
rm -f $htpasswdFile

echo -n "$2:" >> $htpasswdFile

password=$3  # The password is passed as a parameter

encrypted_password=$(echo "$password" | openssl passwd -apr1 -stdin)

echo $encrypted_password >> $htpasswdFile

# Add the password protection to the site configuration
configFile="/etc/nginx/sites-available/$1.conf"
# Remove the old password protection
sed -i '/auth_basic/d' $configFile
# Add auth_basic after server line
sed -i "/server {/a \ \ \ \ auth_basic \"Restricted Access\";\n\ \ \ \ auth_basic_user_file /etc/nginx/.htpasswd$1;" $configFile

# Check nginx configuration and reload if it's correct
nginx -t
if [ $? -eq 0 ]; then
    /etc/init.d/nginx reload
fi
