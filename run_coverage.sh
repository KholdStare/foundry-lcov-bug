#!/bin/bash
set -eu

ROOT_DIR=$(dirname ${BASH_SOURCE[0]})

pushd ${ROOT_DIR} >/dev/null

forge coverage --ffi --report lcov $@

HTML_DIR=reports/coverage

mkdir -p reports
rm -rf ${HTML_DIR}

# generate HTML report based on lcov file
genhtml --branch-coverage --legend -o ${HTML_DIR} lcov.info

echo ${HTML_DIR}/index.html

# Shows 2 out of 4 functions covered (only 2 exist)
lcov --summary lcov.info

# Fails if `functions` coverage is not 100%
lcov --summary lcov.info | grep functions | grep "100.0%"