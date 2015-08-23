#!/bin/bash

set -e

cd "$( dirname "${BASH_SOURCE[0]}" )"

ADMIN_EMAILS=${ADMIN_EMAILS:-admin@example.com}
DB_HOST=${DB_HOST:-mysql}

cp hackpad/etherpad/etc/etherpad.localdev-default.properties hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s/__email_addresses_with_admin_access__/$ADMIN_EMAILS/g hackpad/etherpad/etc/etherpad.local.properties
sed -i.bak s,mysql://localhost,mysql://$DB_HOST,g hackpad/etherpad/etc/etherpad.local.properties

exec hackpad/bin/run.sh
