# Firefox on Docker

## Objective

Use an isolate Firefox for development test. Every new instance is clean.

## Usage

```sh
docker-firefox
```

## Installation

### From docker hub

```sh
# Install docker for your distribution
git clone https://gitlab.com/uzka/devel-docker-firefox.git
cd devel-docker-firefox
make download
sudo make install
```

### Local build

```sh
# Install docker for your distribution
git clone https://gitlab.com/uzka/devel-docker-firefox.git
cd devel-docker-firefox
make
sudo make install
```

