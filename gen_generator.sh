#!/usr/bin/env sh

consul-template -once -template "/root/get_certificates.sh.template:/usr/local/bin/get_certificates.sh" \
  && chmod +x /usr/local/bin/get_certificates.sh \
  && /usr/local/bin/get_certificates.sh

consul-template -once -template "/root/generator.sh.template:/usr/local/bin/generator.sh" \
  && chmod +x /usr/local/bin/generator.sh \
  && /usr/local/bin/generator.sh
