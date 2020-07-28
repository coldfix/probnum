#! /usr/bin/env bash

# Usage:
#   startjob.sh BRANCH BEFORE AFTER
#
# Runs benchmarks on all commits in the range BEFORE..AFTER.
#
# Expect environment variables $GITHUB_TOKEN and $RUNNER_NAME.

set -ex

ref="${1##refs/heads/}"
before="${2}"
after="${3}"
prefix=$(git rev-parse --show-toplevel)/..

slug=coldfix/probnum
repo="https://${GITHUB_TOKEN}@github.com/${slug}"

# Needed for pushing
git config --global user.name "Benchmark Bot"
git config --global user.email "jonathan.wenger@uni-tuebingen.de"

# Setup environment
cd "$prefix"
python -m venv env
source env/bin/activate
pip install --no-cache-dir asv virtualenv

# Fetch database
cd "$prefix/src"
mkdir -p benchmarks
mkdir -p docs/_build
git clone "${repo}-benchmarks.git" benchmarks/.asv -b "db-${ref}"
git clone "${repo}-benchmarks.git" docs/_build/html -b gh-pages

# Run benchmarks
cd "$prefix/src/benchmarks"
asv machine --machine "${RUNNER_NAME}" --yes
asv run --skip-existing-commits "${after}~10..${after}"
asv publish

# Update database
cd "$prefix/src/benchmarks/.asv"
git add results
git commit -m "Update database: ${after}~10..${after}"
git push

# Deploy to github
cd "$prefix/src/docs/_build/html"
touch .nojekyll
git add benchmarks .nojekyll
git commit -m "Results from $(date '+%F %T') at ${after}"
git push
