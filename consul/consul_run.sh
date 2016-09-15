#!/bin/bash
/bin/consul agent -server -bootstrap -data-dir /tmp/consul -config-dir /etc/consul.d -client 0.0.0.0 -ui
