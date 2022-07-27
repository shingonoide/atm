# syntax=docker/dockerfile:1
FROM ruby:3.1.2
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get update -qq && apt-get install -y nodejs postgresql-client \
    && npm install -g heroku && apt-get clean autoclean && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
