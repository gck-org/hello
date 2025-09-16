#!/bin/sh

hello="$(pwd)/bin/hello"

fatal() {
    echo "fatal: $*" >&2
    exit 1
}

[ ! -d "./src" ] && fatal "must be run from parent directory"

{
$hello --help || fatal "failed on --help"
$hello --version || fatal "failed on --version"

$hello foo || fatal "failed to greet user"
} > build/test.log 2>&1
