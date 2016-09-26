FROM kaktuss/letsencrypt-simp_le-auto:0.12

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

ENV CONSUL_HTTP_ADDR=
ENV CONSUL_TOKEN=
ENV VAULT_ADDR=
ENV VAULT_TOKEN=

ENV CERTS_VAULT_PATH=secret/certificates
ENV CERTS_DIR=/etc/simp_le/

COPY consul-template_0.16.0_SHA256SUMS /usr/local/bin/consul-template_0.16.0_SHA256SUMS
COPY gen_generator.sh /usr/local/bin/gen_generator.sh
COPY generator.sh.template /root/generator.sh.template
COPY service.template /root/service.template
COPY get_certificates.sh.template /root/get_certificates.sh.template
COPY vault_0.6.1_SHA256SUMS /usr/local/bin/vault_0.6.1_SHA256SUMS
COPY skip.sh /usr/local/bin/skip.sh
COPY generator.hcl.template /root/generator.hcl.template

RUN apk add --update-cache curl unzip \

  && cd /usr/local/bin \

  && curl -L https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip -o consul-template_0.16.0_linux_amd64.zip \
  && sha256sum -c consul-template_0.16.0_SHA256SUMS \
  && unzip consul-template_0.16.0_linux_amd64.zip \
  && rm consul-template_0.16.0_linux_amd64.zip consul-template_0.16.0_SHA256SUMS \

  && curl -L https://releases.hashicorp.com/vault/0.6.1/vault_0.6.1_linux_amd64.zip -o vault_0.6.1_linux_amd64.zip \
  && sha256sum -c vault_0.6.1_SHA256SUMS \
  && unzip vault_0.6.1_linux_amd64.zip \
  && rm vault_0.6.1_linux_amd64.zip vault_0.6.1_SHA256SUMS \

  && apk del curl unzip && rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/gen_generator.sh"]
