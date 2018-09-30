#!/bin/bash

set -e

GREEN='\033[0;32m'
NC='\033[0m' # No Color

docker build -t edyan_adminer_test .

echo ""
echo -e "${GREEN}Testing ${NC}"
cd tests
dgoss run edyan_adminer_test
