FROM kaktuss/letsencrypt-simp_le-auto:0.17

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

ENV CONSUL_HTTP_ADDR=
ENV CONSUL_TOKEN=
ENV VAULT_ADDR=
ENV VAULT_TOKEN=

ENV CERTS_VAULT_PATH=secret/certificates

COPY consul-template_0.16.0_SHA256SUMS /usr/local/bin/consul-template_0.16.0_SHA256SUMS

RUN \
  apk add --update-cache curl unzip

RUN \
  cd /usr/local/bin \

  && curl -L https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip -o consul-template_0.16.0_linux_amd64.zip \
  && sha256sum -c consul-template_0.16.0_SHA256SUMS \
  && unzip consul-template_0.16.0_linux_amd64.zip \
  && rm consul-template_0.16.0_linux_amd64.zip consul-template_0.16.0_SHA256SUMS

RUN \
  apk del curl unzip && rm -rf /var/cache/apk/*

COPY generator.hcl /etc/generator.hcl
COPY simp_le.conf.template /root/simp_le.conf.template
COPY simp_le_new.conf.template /root/simp_le_new.conf.template
COPY generator.sh /usr/local/bin/generator.sh
COPY store.sh /usr/local/bin/store.sh
COPY skip.sh /usr/local/bin/skip.sh

ENTRYPOINT consul-template -config /etc/generator.hcl
