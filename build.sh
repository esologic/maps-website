#!/bin/bash

nvm install 16
nvm use 16

pnpm --prefix ./themes/bridget-maps run build
hugo "$@"