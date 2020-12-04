#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install


if ! grep -qFx $OSVER /opt/farm/ext/compat-rclocal/config/use-compat.conf; then
	echo "skipping /etc/rc.local setup (not required)"
	exit 0
fi

if [ ! -f /etc/rc.local ]; then
	echo "setting up /etc/rc.local from template"
	install_copy /opt/farm/ext/compat-rclocal/templates/rc.local /etc/rc.local
	chmod +x /etc/rc.local
fi

if [ ! -f /etc/systemd/system/rc-local.service ]; then
	install_copy /opt/farm/ext/compat-rclocal/templates/rc-local.service /etc/systemd/system/rc-local.service
	systemctl enable rc-local
fi
