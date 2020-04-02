#!/bin/bash

RUNNER_NAME=${RUNNER_NAME:-$(hostname)}
RUNNER_DIR=${RUNNER_DIR:-_work}

/runner/config.sh --unattended --url "$GITHUB_URL" --token "$GITHUB_TOKEN" --name $RUNNER_NAME --work $RUNNER_DIR

/runner/run.sh