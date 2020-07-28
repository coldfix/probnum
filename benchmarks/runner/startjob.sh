#! /usr/bin/env bash

# Usage:
#   startjob.sh BRANCH BEFORE AFTER
#
# Runs benchmarks on all commits in the range BEFORE..AFTER.
#
# Expect environment variables $GITHUB_TOKEN and $RUNNER_NAME.

set -e

ref="${1##refs/heads/}"
before="${2}"
after="${3}"
prefix=$(mktemp -d /benchmarks/runs/XXXXXXXX)

# slug=probabilistic-numerics/probnum
slug=coldfix/probnum
repo="https://${GITHUB_TOKEN}@github.com/${slug}"

# Prevent parallel execution(!):
tsp -S 1

# Get repo and run job
git clone "${repo}" "${prefix}/src" -b "${ref}"
cd $prefix/src
if [[ -x "./benchmarks/runner/script.sh" ]]; then
    tsp "./benchmarks/runner/script.sh" "$ref" "$before" "$after"
    tsp -d tsp -C
    #tsp rm -rf "${prefix}"
fi
