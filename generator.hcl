max_stale = "2m"

template {
  source = "/root/simp_le.conf.template"
  destination = "/etc/simp_le.conf"
}

template {
  source = "/root/simp_le_new.conf.template"
  destination = "/etc/simp_le_new.conf"
}

exec {
  command = "/usr/local/bin/generator.sh"
  splay = "120s"
}
