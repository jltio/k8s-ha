#!/bin/bash

python3 -m venv .pyenv
source .pyenv/bin/activate
pip install ansible==2.9.9
ansible --version