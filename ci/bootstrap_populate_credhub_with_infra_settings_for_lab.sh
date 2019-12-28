#!/bin/bash
set -eu

REPO_ROOT_DIR="$(dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd ))"
: "${LAB_NAME:? LAB_NAME must be set}"
: "${INPUT_VARS_YAML:? INPUT_VARS_YAML must be set}"
: "${CREDHUB_VAR_PREFIX:? CREDHUB_VAR_PREFIX must be set}"
echo "Using CredHub prefix: $CREDHUB_VAR_PREFIX"
if [[ ! -f $INPUT_VARS_YAML ]];then
  echo "File not found: $INPUT_VARS_YAML"
  exit 1
fi

# OpsMan section
credhub set -t value -n /concourse/main/${CREDHUB_VAR_PREFIX}_opsman_ip_$LAB_NAME -v "$(bosh int --path=/opsman_ip $INPUT_VARS_YAML)"

public_key=$(cat ~/.ssh/*.pub)
echo "Warning. This might not be desired behaviour as adding public key from your location where you are running this script. This means only you will be able to access the OpsMan over ssh"
echo "Adding ${CREDHUB_VAR_PREFIX}_opsman_ssh_public_key_$LAB_NAME.."
echo "$public_key"
echo "TODO: Generate a key/pair for the ${CREDHUB_VAR_PREFIX} $LAB_NAME OpsMan in CredHub and create a script that can add the private key to the local SSH agent of anyone needing access to it"
echo "For further info see https://community.pivotal.io/s/article/generate-an-ssh-key-pair-for-installing-ops-manager-v2-6-on-vsphere"
credhub set -t value -n /concourse/main/${CREDHUB_VAR_PREFIX}_opsman_ssh_public_key_$LAB_NAME -v "$public_key" # Originally implemented on a lab with a shared account for its Tools VM so configuring that ssh key was sufficient
