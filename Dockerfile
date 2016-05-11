FROM ruby:2.3.1-alpine

# Cache dependencies
COPY ["Gemfile", "Gemfile.lock", "/tmp/cache/"]
WORKDIR /tmp/cache
RUN bundle install && rm -rf /tmp/cache

# Copy code
COPY . /root/app/
WORKDIR /root/app

# Registers bundle in working directory
RUN bundle install

# Expose server port
EXPOSE 3000

# Start the server & tail logs in order to sustain a foreground process
CMD trap exit TERM; bundle exec rake server:start && tail -f tmp/logs/server_console.log
