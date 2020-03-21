ARG ruby_version=2.6.0

FROM ruby:$ruby_version

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ammancilla/war_machine/docker/bin/install)"

ENTRYPOINT ["/bin/zsh"]

WORKDIR  /root
