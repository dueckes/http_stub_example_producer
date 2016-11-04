http_stub_example_producer
--------------------------

An example of a producer service that verifies HTTP API contracts via [http_stub](https://github.com/MYOB-Technology/http_stub)

### Status
[![Build Status](https://travis-ci.org/MYOB-Technology/http_stub_example_producer.png)](https://travis-ci.org/MYOB-Technology/http_stub_example_producer)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/http_stub_example_producer/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/http_stub_example_producer)
[![Test Coverage](https://codeclimate.com/github/MYOB-Technology/http_stub_example_producer/badges/coverage.svg)](https://codeclimate.com/github/MYOB-Technology/http_stub_example_producer/coverage)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/http_stub_example_producer.png)](https://gemnasium.com/MYOB-Technology/http_stub_example_producer)

### Running the Producer
- Install [Docker](https://www.docker.com/)
- `docker build -t http_stub_example_producer .`
- `docker run -d -p 3000:3000 http_stub_example_producer`
- Producer is available on ```http://localhost:3000```

### How do I experiment with it?
Run terminal: `docker run -it -p 3000:3000 -v ~/work/http_stub_example_producer:/root/app http_stub_example_producer /bin/sh`
