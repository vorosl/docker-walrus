# Docker for Walrus compilement

The repository contains Docker files and supporting scripts to make the development easier.

## Software package requirements

- docker
- docker-compose
- python3

Example installation:

```bash
sudo apt-get install -y docker-ce docker-compose python3
```

See more about `docker-compose` at [this link](https://docs.docker.com/compose/).

## Setup

- Run `./compileWalrus.py -s <WALRUS_DIR>`, where `<WALRUS DIR>` is the path to Walrus repo (it could be relative)
  - It creates Docker containers.

**TIP:** To free up some space the docker build cache can be removed with `docker builder prune` command.

## Compile Walrus on different architectures

- Run `./compileWalrus.py <WALRUS_DIR>` to compile to all architectures, what this Docker environment supports (3. line in `compileWalrus.py`)

- For more info, run `./compileWalrus.py --help`

