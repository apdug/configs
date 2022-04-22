#!/bin/bash
mkdir -p /webapps/clkec/production
mkdir -p /webapps/clkec/production/logs
mkdir -p /webapps/clkec/production/socks
cd /webapps/clkec/production
git clone $REPO project
