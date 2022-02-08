#!/bin/bash
set -e

rm -f /pai-learning/tmp/pids/server.pid

exec "$@"
