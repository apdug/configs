#!/bin/bash

if ! [ -f ~/.pyenv/bin/pyenv ]; then
  curl https://pyenv.run | bash
fi

if ! [ -f ~/.pyenv/bin/pyenv ]; then
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
fi

source ~/.bashrc

mkdir -p /webapps/clkec/production
mkdir -p /webapps/clkec/production/logs
mkdir -p /webapps/clkec/production/socks
cd /webapps/clkec/production

if ! [ -d /webapps/clkec/production/project ]; then
  git clone $1 project
fi
cd project
git pull
if [ -e .python-version ]; then
    pyenv install -s `cat .python-version`
    # poetry init -q
    poetry env use `cat .python-version`
    poetry config virtualenvs.create true --local
    poetry config virtualenvs.in-project true --local
fi
poetry env use `cat .python-version`
cd ~/production/project/ && ~/.poetry/bin/poetry run pip install --upgrade pip && ~/.poetry/bin/poetry install --no-dev
