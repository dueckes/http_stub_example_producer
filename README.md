http_stub_producer_example
--------------------------

An example of the producer side of verifying contracts via [http_stub](https://github.com/MYOB-Technology/http_stub).

### Status
[![Build Status](https://travis-ci.org/MYOB-Technology/http_stub_producer_example.png)](https://travis-ci.org/MYOB-Technology/http_stub_producer_example)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/http_stub_producer_example/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/http_stub_producer_example)
[![Test Coverage](https://codeclimate.com/github/MYOB-Technology/http_stub_producer_example/badges/coverage.svg)](https://codeclimate.com/github/MYOB-Technology/http_stub_producer_example/coverage)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/http_stub_producer_example.png)](https://gemnasium.com/MYOB-Technology/http_stub_producer_example)

### Running the Producer
- Install [Docker](https://www.docker.com/)
- `docker build -t http_stub_producer_example .`
- `docker run -d -p 3000:3000 http_stub_producer_example`
- Producer is available on ```http://<docker-machine-ip>:3000```

### How do I experiment with it?
Run terminal: `docker run -it -p 3000:3000 -v ~/work/http_stub_producer_example:/root/app http_stub_producer_example /bin/sh`
