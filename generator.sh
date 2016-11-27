#!/usr/bin/env sh

mkdir -p /etc/new_simp_le-auto.d
rm -rf /etc/new_simp_le-auto.d/*

files=$( ls $AUTO_CONF_D )

for file in $files; do
  server_name=$( cat "$AUTO_CONF_D/$file" )
  if [ ! -f "${CERTS_DIR}fullchain_${server_name}.pem" ]; then
    echo "New service $server_name"
    cp $file /etc/new_simp_le-auto.d
  fi
done

AUTO_CONF_D=/etc/new_simp_le-auto.d /etc/periodic/weekly/gen

rm -rf /etc/new_simp_le-auto.d/*

crond -f
