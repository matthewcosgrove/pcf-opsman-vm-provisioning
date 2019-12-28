#!/bin/bash

set -eu
: "${GOVC_URL:? GOVC_URL must be set }"
: "${GOVC_DATACENTER:? GOVC_DATACENTER must be set }"
: "${GOVC_USERNAME:? GOVC_USERNAME must be set }"
: "${GOVC_PASSWORD:? GOVC_PASSWORD must be set }"
: "${OM_IP:? OM_IP must be set }"

state_yaml_location=config
state_yaml=$state_yaml_location/state.yml
if [ -f "$state_yaml" ]; then
    pushd $state_yaml_location > /dev/null
    upstream_repo=$(git remote -v | awk 'NR==1 {print $2}')
    popd > /dev/null
    echo "$state_yaml exists. Skipping removal of OpsMan VM. To enable removing the OpsMan VM, delete the state.yml file, commit and push to $upstream_repo"
    exit 0
else
    echo "$state_yaml does not exist. Proceeding with removal"
fi

export GOVC_INSECURE=true
echo "Starting opsman removal if exists for $OM_IP"
set +e
echo "Output from vm.info for ip $OM_IP NOTE: If VM does not exist the govc output will indicate so"
govc vm.info --vm.ip $OM_IP
echo "Executing vm.destroy.."
govc vm.destroy --vm.ip $OM_IP
set -e
echo "Completed opsman removal if exists for $OM_IP"

