#!/bin/bash
set -eu

PIPELINE_NAME=${PIPELINE_NAME:-opsman-vm-installs}
credhub set -t value -n /concourse/main/$PIPELINE_NAME/git_repo_uri -v $GIT_REPO_URI
credhub set -t value -n /concourse/main/$PIPELINE_NAME/git_opsman_vm_state_repo_uri -v $STATE_GIT_REPO_URI
