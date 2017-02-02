FROM ruby:2.4.0-alpine

# Update Bundler
RUN gem install bundler

# Cache dependencies
COPY ["Gemfile", "Gemfile.lock", "/tmp/cache/"]
WORKDIR /tmp/cache
RUN bundle install --without development && rm -rf /tmp/cache

# Copy code
COPY . /root/app/
WORKDIR /root/app

# Registers bundle in working directory
RUN bundle install --without development

# Expose server port
EXPOSE 3000

# Start the server & tail logs in order to sustain a foreground process
CMD trap exit TERM; bundle exec rake server:start && tail -f tmp/logs/server_console.log
