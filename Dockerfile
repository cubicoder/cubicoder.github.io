FROM jekyll/jekyll

COPY --chown=jekyll:jekyll Gemfile .
COPY --chown=jekyll:jekyll Gemfile.lock .

RUN bundle install --quiet --clean

CMD ["jekyll", "serve", "--config", "_config.yml,_config.docker.yml"]
