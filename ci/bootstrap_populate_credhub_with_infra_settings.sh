#!/bin/bash
set -eu

REPO_ROOT_DIR="$(dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd ))"
: "${INPUT_VARS_YAML:? INPUT_VARS_YAML must be set}"
: "${CREDHUB_VAR_PREFIX:? CREDHUB_VAR_PREFIX must be set}"
credhub_var_prefix=$CREDHUB_VAR_PREFIX
echo "Using CredHub prefix: $credhub_var_prefix"
if [[ ! -f $INPUT_VARS_YAML ]];then
  echo "File not found: $INPUT_VARS_YAML"
  exit 1
fi

# Keeping in credhub as need to parse array
credhub set -t value -n /concourse/main/${credhub_var_prefix}_vcenter_dns -v "$(bosh int --path=/vcenter_dns/0 $INPUT_VARS_YAML)"

# Needed in pipeline for GOVC
credhub set -t value -n /concourse/main/${credhub_var_prefix}_vcenter_ip -v "$(bosh int --path=/vcenter_ip $INPUT_VARS_YAML)"
credhub set -t value -n /concourse/main/${credhub_var_prefix}_vcenter_datacenter -v "$(bosh int --path=/vcenter_dc $INPUT_VARS_YAML)"
